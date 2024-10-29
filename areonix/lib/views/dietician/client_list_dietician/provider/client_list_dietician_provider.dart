import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/success_constants.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../splash_dietician/provider/index.dart';
import 'cardClient_state.dart';

final clientListDieticianProvider =
    StateNotifierProvider<ClientListDieticianNotifier, CardClientListState>(
  (ref) {
    final dieticianNotifier = ref.watch(dieticianProvider.notifier);
    return ClientListDieticianNotifier(dieticianNotifier);
  },
);

class ClientListDieticianNotifier extends StateNotifier<CardClientListState> {
  ClientListDieticianNotifier(this._dieticianNotifier)
      : super(
          CardClientListState(
            clients: _dieticianNotifier.state.clientList?.map((id) {
                  return CardClientState(clientId: id);
                }).toList() ??
                [],
          ),
        );

  final DieticianNotifier _dieticianNotifier;

  void filterClients(String query) {
    if (query.isEmpty) {
      // Arama yapılmıyorsa tüm client'ları geri yükle ve arama durumu false
      state = state.copyWith(searchingClients: false);
    } else {
      final filteredClients = state.clients.where((client) {
        final fullName =
            '${client.clientName ?? ''} ${client.clientSurname ?? ''}'
                .toLowerCase();
        final lowerCaseQuery = query.toLowerCase();
        return fullName.contains(lowerCaseQuery);
      }).toList();

      state = state.copyWith(
        filteredClients: filteredClients,
        searchingClients: true, // Arama yapıldığı durumda true
      );
    }
  }

  Future<void> addClient(
      String clientId, BuildContext context, WidgetRef ref) async {
    // appointed_clients ve dietician_pool listelerini kontrol etmek için verileri çekiyoruz
    final appointedClientsSnapshot = await FirebaseCollections.pool.reference
        .doc('0') // appointedClients doküman ID'si "0" olan dokümanı çekiyoruz
        .get();

    final dieticianPoolSnapshot = await FirebaseCollections.pool.reference
        .doc('1') // dietician_pool doküman ID'si "1" olan dokümanı çekiyoruz
        .get();

    var isClientAlreadyAppointed = false;
    var isClientADietician = false;
    var isClientAlreadyInDieticianList = false;

    // appointed_clients kontrolü
    if (appointedClientsSnapshot.exists) {
      final appointedClientsData =
          appointedClientsSnapshot.data() as Map<String, dynamic>?;
      final appointedClientList =
          appointedClientsData?['appointed_clients'] as List<dynamic>?;

      if (appointedClientList != null &&
          appointedClientList.contains(clientId)) {
        isClientAlreadyAppointed = true;
      }
    }

    // dietician_pool kontrolü
    if (dieticianPoolSnapshot.exists) {
      final dieticianPoolData =
          dieticianPoolSnapshot.data() as Map<String, dynamic>?;
      final dieticianPoolList =
          dieticianPoolData?['dieticians'] as List<dynamic>?;

      if (dieticianPoolList != null && dieticianPoolList.contains(clientId)) {
        isClientADietician = true;
      }
    }

    // Diyetisyenin clientList'inde zaten var mı kontrolü
    if (_dieticianNotifier.state.clientList != null &&
        _dieticianNotifier.state.clientList!.contains(clientId)) {
      isClientAlreadyInDieticianList = true;
    }

    // Hatalı durumları kontrol et
    if (isClientAlreadyInDieticianList) {
      showCustomSnackBar(
        context: context,
        message: ErrorConstants.addClientIsClientAlreadyInDieticianList,
      );
      return;
    }

    if (isClientAlreadyAppointed) {
      showCustomSnackBar(
        context: context,
        message: ErrorConstants.addClientIsClientAlreadyAppointed,
      );
      return;
    }

    if (isClientADietician) {
      showCustomSnackBar(
        context: context,
        message: ErrorConstants.addClientIsClientADietician,
      );
      return;
    }

    // Eğer hasta eklenmemişse normal ekleme sürecine geç
    await _dieticianNotifier.addClientToDietician(clientId);

    // Diyetisyenin ID'sini al
    final dieticianId = _dieticianNotifier.state.id;

    // Hasta bilgilerini güncelle: dietician field'ını ekle
    await FirebaseCollections.client.reference
        .doc(clientId) // Hasta dokümanını alıyoruz
        .update({
      'dietician':
          dieticianId, // Diyetisyenin ID'sini 'dietician' alanına ekliyoruz
    });

    final updatedClientNames = await fetchClientNames([clientId], ref);
    final newClient = updatedClientNames.entries.map((entry) {
      return CardClientState(
        clientId: entry.key,
        clientName: entry.value.split(' ')[0],
        clientSurname: entry.value.split(' ')[1],
      );
    }).first;

    // Hasta appointedClients koleksiyonundaki 0 ID'li dokümanın appointed_clients array'ine ekleniyor
    await FirebaseCollections.pool.reference
        .doc(
      '0',
    )
        .update({
      'appointed_clients': FieldValue.arrayUnion([clientId]),
    });

    state = state.copyWith(clients: [...state.clients, newClient]);
  }

  Future<void> removeClient(String clientId) async {
    if (_dieticianNotifier.state.clientList!.contains(clientId)) {
      await _dieticianNotifier.removeClientFromDietician(clientId);
      state = state.copyWith(
        clients: state.clients
            .where((client) => client.clientId != clientId)
            .toList(),
      );
    }
  }

  Future<void> refreshClients(WidgetRef ref) async {
    await _dieticianNotifier.fetchAndLoad();
    final clientIds = _dieticianNotifier.state.clientList ?? [];

    final clientNames = await fetchClientNames(clientIds, ref);
    final clients = clientNames.entries.map((entry) {
      return CardClientState(
        clientId: entry.key,
        clientName: entry.value.split(' ')[0],
        clientSurname: entry.value.split(' ')[1],
      );
    }).toList();

    state = state.copyWith(clients: clients);
  }

  Future<Map<String, String>> fetchClientNames(
      List<String> clientIds, WidgetRef ref) async {
    final clientNames = <String, String>{};

    // isFetchingClient durumunu true yap
    ref.read(clientListDieticianProvider.notifier).setFetchingClient(true);

    for (final clientId in clientIds) {
      final docSnapshot =
          await FirebaseCollections.client.reference.doc(clientId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          final name = data['name'] ?? '';
          final surname = data['surname'] ?? '';
          clientNames[clientId] = '$name $surname';
        }
      }
    }

    // isFetchingClient durumunu false yap
    ref.read(clientListDieticianProvider.notifier).setFetchingClient(false);

    return clientNames;
  }

  // State'i güncelleme yöntemi
  void setFetchingClient(bool isFetching) =>
      state = state.copyWith(isFetchingClient: isFetching);

  Future<void> assignFormToClient(
    String clientId,
    String formId,
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      // Fetch the existing client data from Firestore.
      final clientSnapshot =
          await FirebaseCollections.client.reference.doc(clientId).get();

      if (clientSnapshot.exists) {
        final clientData = clientSnapshot.data() as Map<String, dynamic>?;

        // Retrieve and convert the existing `dieticianForms` and `isFormSubmitted` data.
        var existingForms = <String, List<String>>{};
        var isFormSubmitted = <String, bool>{};

        if (clientData != null) {
          if (clientData['dietician_forms'] != null &&
              clientData['dietician_forms'] is Map<String, dynamic>) {
            existingForms =
                (clientData['dietician_forms'] as Map<String, dynamic>).map(
              (key, value) {
                // Ensure `value` is a `List<String>`.
                if (value is List) {
                  return MapEntry(
                    key,
                    value.map((item) => item as String).toList(),
                  );
                } else {
                  return MapEntry(key, <String>[]);
                }
              },
            );
          }

          if (clientData['isFormSubmitted'] != null &&
              clientData['isFormSubmitted'] is Map<String, dynamic>) {
            isFormSubmitted =
                (clientData['isFormSubmitted'] as Map<String, dynamic>).map(
              (key, value) {
                // Ensure `value` is a `bool`.
                if (value is bool) {
                  return MapEntry(key, value);
                } else {
                  return MapEntry(key, false);
                }
              },
            );
          }
        }

        // Check if the form already exists.
        if (existingForms.containsKey(formId)) {
          showCustomSnackBar(
            context: context,
            message: "Bu form zaten gönderilmiş.",
          );
          return;
        }

        // Retrieve the form content from the state.
        final dieticianState = ref.read(dieticianProvider);
        List<String>? formContent;
        if (dieticianState.dieticianForms != null) {
          formContent = dieticianState.dieticianForms?[formId];
        }

        if (formContent == null) {
          showCustomSnackBar(
            context: context,
            message: "Form içeriği bulunamadı.",
          );
          return;
        }

        // Add the form to the `dieticianForms` map.
        existingForms[formId] = formContent;

        // Add the form to the `isFormSubmitted` map with a value of `false`.
        isFormSubmitted[formId] = false;

        // Save the updated `dieticianForms` and `isFormSubmitted` maps to Firestore.
        await FirebaseCollections.client.reference.doc(clientId).update({
          'dietician_forms': existingForms,
          'isFormSubmitted': {...isFormSubmitted}, // Merge the maps manually
        });

        showCustomSnackBar(
          context: context,
          message: SuccessConstants.formAssignSuccessMessage,
        );
      } else {
        showCustomSnackBar(
          context: context,
          message: ErrorConstants.formAssignErrorMessage,
        );
      }
    } catch (e) {
      showCustomSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
