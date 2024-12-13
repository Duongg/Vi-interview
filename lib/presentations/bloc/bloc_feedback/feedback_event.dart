

abstract class FeedbackEvent {
  const FeedbackEvent();
}
class OnFeedbackEvent extends FeedbackEvent{
  final Map<String, String> mapPrompt;
  final bool isLoading;
  OnFeedbackEvent(this.mapPrompt, {this.isLoading = true});
}