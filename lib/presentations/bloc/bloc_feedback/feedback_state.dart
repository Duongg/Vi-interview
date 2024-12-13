import 'package:vi_interview/domain/model/feedback_response.dart';

abstract class FeedbackState {
  const FeedbackState();
}

class InitialFeedbackState extends FeedbackState {}

class LoadingFeedbackState extends FeedbackState {}

class ErrorGenerateFeedbackState extends FeedbackState {
  final String errorMsg;
  ErrorGenerateFeedbackState(this.errorMsg);
}

class SuccessGenerateFeedbackState extends FeedbackState {
  // final List<FeedbackResponse> listFeedback;
  // final Map<String, String> mapPrompt;

  Map<Map<String, String>, FeedbackResponse> qnaFeedbackMap;
  SuccessGenerateFeedbackState(this.qnaFeedbackMap);
}
