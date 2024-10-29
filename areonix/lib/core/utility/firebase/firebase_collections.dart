import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  tag,
  recommended,
  version,
  category,
  client,
  trainer,
  clientResponse,
  dieticianForms,
  pool,
  ;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
