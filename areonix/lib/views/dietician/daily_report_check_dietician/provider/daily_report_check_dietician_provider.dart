import 'dart:convert';
import 'package:areonix/core/models/client.dart';
import 'package:areonix/core/utility/firebase/firebase_utility.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'cardClient_state.dart';

final dailyReportCheckDieticianProvider = StateNotifierProvider<
    DailyReportCheckDieticianNotifier, DailyReportListState>(
  (ref) {
    final dieticianNotifier = ref.watch(dieticianProvider.notifier);
    return DailyReportCheckDieticianNotifier(dieticianNotifier);
  },
);

class DailyReportCheckDieticianNotifier
    extends StateNotifier<DailyReportListState> with FirebaseUtility {
  DailyReportCheckDieticianNotifier(this._dieticianNotifier)
      : super(
          DailyReportListState(
            clients: _dieticianNotifier.state.clientList?.map((id) {
                  return DailyReportCardState(clientId: id);
                }).toList() ??
                [],
          ),
        );

  final DieticianNotifier _dieticianNotifier;

  // Müşterileri filtreleme işlemi
  void filterClients(String query) {
    if (query.isEmpty) {
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
        searchingClients: true,
      );
    }
  }

  // Client'ları yenileme işlemi
  Future<void> refreshClients() async {
    await _dieticianNotifier.fetchAndLoad();
    final clientIds = _dieticianNotifier.state.clientList ?? [];

    final clientNames = await fetchClientNames(clientIds);
    final clients = clientNames.entries.map((entry) {
      return DailyReportCardState(
        clientId: entry.key,
        clientName: entry.value.split(' ')[0],
        clientSurname: entry.value.split(' ')[1],
      );
    }).toList();

    state = state.copyWith(clients: clients);
  }

  // Client dosyalarını listeleme ve gruplama
  Future<void> fetchAllClientsFiles() async {
    final clientList = _dieticianNotifier.state.clientList;

    print("clientList $clientList");

    // Eğer client listesi boşsa işlemi durdur
    if (clientList == null || clientList.isEmpty) {
      print('No clients to fetch files for.');
      return;
    }

    // Tüm client dosyalarını saklamak için bir liste oluşturuyoruz
    final allFilesList = <Map<String, String>>[];

    // Her bir clientId için dosyaları çekiyoruz
    for (final clientId in clientList) {
      final clientFilesList = await _fetchFilesForClient(clientId);
      if (clientFilesList != null && clientFilesList.isNotEmpty) {
        // Her client'in dosyalarını toplu listeye ekliyoruz
        allFilesList.addAll(clientFilesList);
      }
    }

    // Tüm client dosyalarını state'e kaydediyoruz
    state = state.copyWith(allFiles: allFilesList);
    print('All clients files: $allFilesList');
  }

  // Assuming you have a fetchList function to retrieve client information
  Future<List<Map<String, String>>?> _fetchFilesForClient(
    String clientId,
  ) async {
    final url = Uri.parse(
      'https://us-central1-dietracker0.cloudfunctions.net/getFilesList?clientId=$clientId',
    );

    try {
      // Fetch the list of files for the client
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Fetch client data to get diet length
        final items = await fetchList<Client, Client>(
          Client(),
          FirebaseCollections.client,
          queryBuilder: (query) => query.where('id', isEqualTo: clientId),
        );

        // Assuming the Client class has a 'diet' field
        if (items!.isNotEmpty) {
          final Client client = items.first;
          final int dietLength = client.diet!.length; // Assuming diet is a list

          // Process the file list
          final decodedJson = json.decode(response.body) as List<dynamic>;
          final fileNames = decodedJson.map((item) => item.toString()).toList();

          // List to store the file information
          final clientFilesList = <Map<String, String>>[];

          for (var fileName in fileNames) {
            // Extract date from file path (DD-MM-YYYY format)
            final regExpDate = RegExp(r'reports/(\d{1,2})-(\d{1,2})-(\d{4})/');
            final dateMatch = regExpDate.firstMatch(fileName);

            // Extract meal name from the file path (e.g., sabah, öğle, akşam)
            final regExpMeal =
                RegExp(r'reports/\d{1,2}-\d{1,2}-\d{4}/(.+)\.jpg');
            final mealMatch = regExpMeal.firstMatch(fileName);

            if (dateMatch != null && mealMatch != null) {
              // Extract day, month, and year from the match
              String day = dateMatch.group(1)!;
              String month = dateMatch.group(2)!;
              String year = dateMatch.group(3)!;

              // Add leading zeros to day and month if necessary
              day = day.padLeft(2, '0');
              month = month.padLeft(2, '0');

              // Extract the meal name
              String meal = mealMatch.group(1)!;

              // Format the date as DD-MM-YYYY
              String formattedDate = '$day-$month-$year';

              // Get the download URL from Firebase Storage
              final ref = FirebaseStorage.instance.ref().child(fileName);
              final downloadUrl = await ref.getDownloadURL();

              // Add the file information to the map, including the diet length
              final fileInfo = {
                'clientId': clientId,
                'date': formattedDate, // Date in DD-MM-YYYY format
                'downloadUrl': downloadUrl,
                'meal': meal,
                'dietLength':
                    dietLength.toString(), // Include diet length in file info
              };

              // Add to the list
              clientFilesList.add(fileInfo);
            }
          }

          // Return the list of client files
          return clientFilesList;
        } else {
          print('No client data found for clientId: $clientId');
        }
      } else {
        print(
            'Failed to fetch file names for client: $clientId. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching file names for client $clientId: $e');
    }
    return null;
  }
}
