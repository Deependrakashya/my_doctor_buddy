import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ✅ Create a new chat for the current user
  Future<String> createNewChat(String? title) async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return '';

    final chatRef =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('chats')
            .doc(); // auto-generated chat ID

    await chatRef.set({
      'title': title ?? 'New Chat',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return chatRef.id;
  }

  /// ✅ Add a user or bot message to a specific chat
  Future<void> addMessageToChat({
    required String chatId,
    required String role, // 'user' or 'bot'
    required String content,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return;

    final messageRef =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc();

    await messageRef.set({
      'role': role,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .doc(chatId)
        .update({'updatedAt': FieldValue.serverTimestamp()});
  }

  /// ✅ Real-time stream of messages in a chat
  Stream<List<Map<String, dynamic>>> getMessagesFromChat(String chatId) {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// ✅ Optional: fetch all user chats (e.g., for sidebar)
  Future<List<Map<String, dynamic>>> getUserChats() async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return [];

    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('chats')
            .orderBy('updatedAt', descending: true)
            .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // add chatId to map
      return data;
    }).toList();
  }
}
