import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  ///id를 아는 경우, 데이터 가져오기
  Future<DocumentSnapshot<Map<String, dynamic>?>> getData({
    required String collection,
    required String doc,
  }) async {
    final reference =
        FirebaseFirestore.instance.collection(collection).doc(doc);
    return await reference.get();
  }
}
