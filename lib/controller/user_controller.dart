import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:software_engineering/service/firestore_service.dart';

class UserController extends GetxController {
  final service = FirestoreService.instance;

  final user = FirebaseAuth.instance.currentUser;

  String email = '';
  String name = '';

  @override
  void onInit() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();

    if (snapshot.exists) {
      email = snapshot.data()?['email'];
      name = snapshot.data()?['name'];
    }
    update();
    super.onInit();
  }
}
