import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MatchContorller extends GetxController {
  late int docsLength;
  late List<List<dynamic>> combination = [];

  @override
  void onInit() async {
    await FirebaseFirestore.instance.collection('team').get().then((snapshot) {
      docsLength = snapshot.docs.length;
      if (docsLength > 2) {
        for (int i = 0; i < docsLength; i++) {
          for (int j = i + 1; j < docsLength; j++) {
            combination.add([
              snapshot.docs[i]['docID'],
              snapshot.docs[j]['docID'],
            ]);
          }
        }
      } else {
        List<dynamic> temp = [];
        for (int n = 0; n < docsLength; n++) {
          temp.add(snapshot.docs[n]['docID']);
        }
        combination.add(temp);
      }
    });
    super.onInit();
  }
}
