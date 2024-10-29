import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirebaseUtility {
  /// Fetch list from database
  Future<List<T>?> fetchList<T extends IdModel, R extends BaseFirebaseModel<T>>(
    R data,
    FirebaseCollections collections, {
    Query Function(Query)? queryBuilder,
  }) async {
    final collectionReference = collections.reference;
    Query query = collectionReference;

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final response = await query.withConverter<T>(
      fromFirestore: (snapshot, options) {
        return data.fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return {};
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }

  Future<void> saveClientResponse(ClientResponse response) async {
    final collectionReference = FirebaseFirestore.instance
        .collection('responses'); // Firebase collection name

    final docReference = collectionReference.doc(response.id);
    await docReference.set(response.toJson());
  }

  /// Update document in the database
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(documentId)
          .update(data);
    } catch (e) {
      print("Error updating document: $e");
      rethrow;
    }
  }

  /// Fetch client names by IDs from the database
  Future<Map<String, String>> fetchClientNames(List<String> clientIds) async {
    final Map<String, String> clientNames = {};

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
    return clientNames;
  }
}
