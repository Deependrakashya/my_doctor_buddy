import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_doctor_buddy/model/q_n_a_model.dart';

class FirestoreServices {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> saveQnA({
    required String question,
    required String answer,
    String? imageBase64,
  }) async {
    String listName = question.removeAllWhitespace;
    if (user!.isAnonymous == false) {
      try {
        var data = await FirebaseFirestore.instance
            .collection('users') // Collection
            .doc(user?.email ?? 'anonymous') // 👈 Specific document
            .set({
              'qna': FieldValue.arrayUnion([
                {
                  'question': question,
                  'answer': answer,
                  'userId': user?.uid,
                  'timestamp': Timestamp.now(),
                  'role': 'user',
                  'imageBase64': imageBase64,
                },
              ]),
            }, SetOptions(merge: true)); // 👈 Avoid overwriting old data
      } catch (e) {
        log('error on saving QNA $e');
      }
    }
  }

  Future<List<QnAModel>> fetchUserQnAs() async {
    try {
      if (user != null && !user!.isAnonymous) {
        final snapshot =
            await FirebaseFirestore.instance
                .collection('qna')
                .where('userId', isEqualTo: user!.uid)
                .orderBy('timestamp', descending: true)
                .get();

        return snapshot.docs
            .map((doc) => QnAModel.fromJson(doc.data()))
            .toList();
      }
      return [];
    } catch (e) {
      log('Error fetching QnAs: $e');
      return [];
    }
  }
}
