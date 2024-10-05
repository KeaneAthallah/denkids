import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quiz_results');

  Future<void> addQuizResult(Map<String, dynamic> quizData) {
    return quizCollection.add(quizData);
  }
}
