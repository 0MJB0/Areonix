import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dietician_state.dart';

// Provider definition
final dieticianProvider =
    StateNotifierProvider<DieticianNotifier, DieticianState>(
  (ref) => DieticianNotifier(),
);

class DieticianNotifier extends StateNotifier<DieticianState>
    with FirebaseUtility {
  DieticianNotifier() : super(const DieticianState());

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);

    // Fetch Dietician information and update clientID
    await fetchDieticianInformation();

    state = state.copyWith(isLoading: false);
  }

  Future<void> fetchDieticianInformation() async {
    try {
      // Get the logged-in user's ID
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        print("User is not logged in.");
        return;
      }

      // Fetch data based on the logged-in user's ID
      final items = await fetchList<Trainer, Trainer>(
        const Trainer(),
        FirebaseCollections.trainer,
        queryBuilder: (query) => query.where('id', isEqualTo: userId),
      );

      if (items != null && items.isNotEmpty) {
        final dietician = items.first;

        print("Fetched dietician data: ${dietician.toJson()}");

        // Update state with all information from the Dietician model
        state = state.copyWith(
          clientList: dietician.clientList,
          id: dietician.id,
          mail: dietician.mail,
          name: dietician.name,
          password: dietician.password,
          totalDay: dietician.totalDay,
          surname: dietician.surname,
          registerDate: dietician.registerDate,
          finishDate: dietician.finishDate,
          dieticianForms: dietician.dieticianForms,
        );
      } else {
        print("No dietician data found.");
      }
    } catch (e, stackTrace) {
      print("Error fetching dietician data: $e");
      print(stackTrace);
    }
  }

  Future<void> addClientToDietician(String clientId) async {
    if (state.clientList != null && !state.clientList!.contains(clientId)) {
      final updatedClientList = [...state.clientList!, clientId];

      try {
        // Firebase'de güncelleme yapılıyor
        await FirebaseCollections.trainer.reference
            .doc(state.id)
            .update({'client_list': updatedClientList});
        print("Successfully updated client list in Firebase");

        // Firebase güncellemesi başarılı olursa, durumu güncelleyin
        state = state.copyWith(clientList: updatedClientList);
        print("State after Firebase update: ${state.clientList}");
      } catch (e) {
        print("Error updating client list: $e");
      }
    } else {
      print(
          "Client list is null or clientId already exists, cannot add client.");
    }
  }

// Method to remove a client ID from the dietician's clientList
  Future<void> removeClientFromDietician(String clientId) async {
    if (state.clientList != null && state.clientList!.contains(clientId)) {
      final updatedClientList =
          state.clientList!.where((id) => id != clientId).toList();
      state = state.copyWith(clientList: updatedClientList);

      try {
        await FirebaseCollections.trainer.reference
            .doc(state.id)
            .update({'client_list': updatedClientList});

        // appointedClients dokümanındaki appointed_clients listesinden clientId'yi kaldırın
        await FirebaseCollections.pool.reference.doc('0').update({
          'appointed_clients': FieldValue.arrayRemove([clientId]),
        });

        print(
            "Successfully removed client from dietician and appointedClients.");
      } catch (e) {
        print("Error removing client from list: $e");
      }
    }
  }
}
