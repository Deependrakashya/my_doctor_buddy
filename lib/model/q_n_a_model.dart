import 'package:cloud_firestore/cloud_firestore.dart';

class QnAModel {
  final String question;
  final String answer;
  final String userId;
  final DateTime timestamp;
  final String role;
  final String? imageBase64; // 🆕 Add this line

  QnAModel({
    required this.question,
    required this.answer,
    required this.userId,
    required this.timestamp,
    required this.role,
    this.imageBase64,
  });

  factory QnAModel.fromJson(Map<String, dynamic> json) {
    return QnAModel(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      userId: json['userId'] ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      role: json['role'] ?? 'user',
      imageBase64: json['imageBase64'], // 🆕 Include this
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'userId': userId,
      'timestamp': timestamp,
      'role': role,
      'imageBase64': imageBase64, // 🆕 Include this
    };
  }
}
