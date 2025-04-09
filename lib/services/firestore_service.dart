import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._privateConstructor();

  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

  factory FirestoreService() {
    return _instance;
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getDocuments() async {
    List<Map<String, dynamic>> dataList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection('house details').get();

      for (var docSnapshot in snapshot.docs) {
        dataList.add(docSnapshot.data());
      }
    } catch (e) {
      throw Exception('Error fetching documents: $e');
    }
    return dataList;
  }
}
