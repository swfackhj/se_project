import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MatchDetailController extends GetxController {
  MatchDetailController({required this.teamName1, required this.teamName2});

  String teamName1;
  String teamName2;

  List<List<dynamic>> scores = [];

  @override
  void onInit() async {
    await FirebaseFirestore.instance
        .collection('match')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .get()
        .then((snapshot) {
      if (snapshot.data()!['$teamName1 VS $teamName2'].length != 0) {
        scores.add(snapshot.data()!['$teamName1 VS $teamName2']);
      }
      scores.add([0, 0]);
    });
    update();
    super.onInit();
  }
}
