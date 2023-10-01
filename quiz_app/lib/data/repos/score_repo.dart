import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/data/model/score_result.dart';

class ScoreRepo {
  final db = FirebaseFirestore.instance;

  ScoreRepo();

  void saveScore(
      double score,
      String difficultyLevel,
      int attempts,
      int wrongAttemps,
      int correctAttempts,
      int categoryIndex,
      String categoryTitle) async {
    final docRef = db.collection("Score").doc();
    Score scoreobj = Score(
        id: docRef.id,
        uid: FirebaseAuth.instance.currentUser!.uid,
        time: DateTime.now(),
        category: categoryTitle,
        categoryIndex: categoryIndex,
        difficultyLevel: difficultyLevel,
        score: score.toStringAsFixed(2),
        attempts: attempts,
        correctAttempts: correctAttempts,
        wrongAttempts: wrongAttemps);
    // FirebaseFirestore.instance.collection("Score").add({
    //   'id': docRef.id,
    //   'uid': FirebaseAuth.instance.currentUser!.uid,
    //   'time': DateTime.now(),
    //   'category': categoryTitle,
    //   'categoryIndex': categoryIndex,
    //   'difficultyLevel': difficultyLevel,
    //   'score': score,
    //   'attempts': attempts,
    //   'correctAttempts': correctAttempts,
    //   'wrongAttempts': wrongAttemps,
    // });
    return docRef.set(scoreobj.toMap()).then(
        (value) => log("The Score saved successfully!"),
        onError: (e) => log("Error: The Score didn't save: $e"));
  }

  Future<QuerySnapshot<Object?>> getLastTenScores(
      String category, String difficultyLevel) async {
    final CollectionReference scoreRef =
        FirebaseFirestore.instance.collection('Score');
    return scoreRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('category', isEqualTo: category)
        .where('difficultyLevel', isEqualTo: difficultyLevel)
        .orderBy('time', descending: true)
        .limit(10)
        .get();
  }
}
