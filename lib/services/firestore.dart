import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quiz_results');

  Future<void> addQuizResult(Map<String, dynamic> quizData) async {
    final quizCollection =
        FirebaseFirestore.instance.collection('quiz_results');
    final querySnapshot =
        await quizCollection.where('name', isEqualTo: quizData['name']).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Update the existing document
      await quizCollection.doc(querySnapshot.docs[0].id).update(quizData);
    } else {
      // Add a new document
      await quizCollection.add(quizData);
    }
  }
}
