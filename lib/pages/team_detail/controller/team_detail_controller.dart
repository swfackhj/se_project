import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeamDetailController extends GetxController {
  RxString leaderUid = ''.obs;
  void getLeaderUid(String docID) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('team').doc(docID).get();

    leaderUid.value = snapshot.data()?['leaderUid'];
    update();
  }
}
