import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MatchContorller extends GetxController {
  List<dynamic> docs = [];
  late List<List<dynamic>> combination = [];

  void getTodayTeams(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    docs.clear();
    combination.clear();
    final format = DateFormat('yyyy-MM-dd');
    final now = DateTime.now();
    final yesterday = DateTime.utc(now.year, now.month, now.day - 1);
    for (int n = 0; n < snapshot.data!.docs.length; n++) {
      if (now.hour >= 0 && now.hour < 8) {
        if (format.format(snapshot.data!.docs[n]['createTime'].toDate()) ==
            format.format(yesterday)) {
          docs.contains(snapshot.data!.docs[n])
              ? null
              : docs.add(snapshot.data!.docs[n]);
        }
      } else {
        if (format.format(snapshot.data!.docs[n]['createTime'].toDate()) ==
            format.format(now)) {
          docs.contains(snapshot.data!.docs[n])
              ? null
              : docs.add(snapshot.data!.docs[n]);
        }
      }
    }
    getTodayMatches();
    update();
  }

  void getTodayMatches() {
    if (docs.length >= 2) {
      for (int i = 0; i < docs.length; i++) {
        for (int j = i + 1; j < docs.length; j++) {
          combination.add([
            docs[i]['docID'],
            docs[j]['docID'],
          ]);
        }
      }
    }
  }
}
