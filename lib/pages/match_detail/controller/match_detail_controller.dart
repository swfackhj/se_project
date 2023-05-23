import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MatchDetailController extends GetxController {
  MatchDetailController(
      {required this.teamUid1,
      required this.teamUid2,
      required this.teamName1,
      required this.teamName2});

  String teamUid1;
  String teamUid2;
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
      for (int n = 0;
          n < snapshot.data()!['$teamName1 VS $teamName2'].length;
          n++) {
        var temp = [];
        temp.add(int.parse(
            snapshot.data()!['$teamName1 VS $teamName2'][n]['$n경기'][1]));
        temp.add(int.parse(
            snapshot.data()!['$teamName1 VS $teamName2'][n]['$n경기'][4]));
        scores.add(temp);
      }
    });
    scores.add([0, 0]);
    update();
    super.onInit();
  }

  void addScore(int index, int team) async {
    if (scores[index][0] != 2 || scores[index][1] != 2) {
      if (scores[index][team] < 2) {
        scores[index][team] += 1;
        if (scores[index][team] == 2) {
          await FirebaseFirestore.instance
              .collection('match')
              .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
              .update({
            '$teamName1 VS $teamName2': FieldValue.arrayUnion([
              {'$index경기': scores[index].toString()}
            ])
          });
          scores.add([0, 0]);
          if (team == 0) {
            int currentWins = 0;
            await FirebaseFirestore.instance
                .collection('team')
                .where('teamName', isEqualTo: teamName1)
                .get()
                .then((snapshot) {
              currentWins = snapshot.docs[0].data()['win'];
            });
            await FirebaseFirestore.instance
                .collection('team')
                .doc(teamUid1)
                .update({'win': currentWins + 1});
          }
        } else if (team == 1) {}
      }
    }
    update();
  }

  void minusScore(int index, int team) {
    if (scores[index][team] > 0 && scores[index][team] != 2) {
      scores[index][team] -= 1;
    }
    update();
  }
}
