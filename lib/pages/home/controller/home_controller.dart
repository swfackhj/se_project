import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late User user;
  late dynamic userSnapshot;

  @override
  void onInit() async {
    user = FirebaseAuth.instance.currentUser!;
    userSnapshot = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get;
    update();
    super.onInit();
  }
}
