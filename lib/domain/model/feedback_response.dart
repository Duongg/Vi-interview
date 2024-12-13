
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FeedbackResponse {
  final int rating;
  final String feedback;
  final String correctAnswer;
  bool isExpanded = false;
  FeedbackResponse({required this.rating, required this.feedback, required this.correctAnswer, required this.isExpanded});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackResponse(
      rating: json['rating'],
      feedback: json['feedback'],
      correctAnswer: json['correct_answer'],
      isExpanded: false,
    );
  }
}
