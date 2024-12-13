import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vi_interview/domain/model/feedback_response.dart';
import 'package:vi_interview/domain/usecase/feedback_usecase.dart';
import 'package:vi_interview/presentations/bloc/bloc_feedback/feedback_event.dart';
import 'package:vi_interview/presentations/bloc/bloc_feedback/feedback_state.dart';

class FeebackBloc extends Bloc<FeedbackEvent, FeedbackState>{
  final FeedbackUsecase feedbackUsecase;

  FeebackBloc({required this.feedbackUsecase}): super(InitialFeedbackState()){
    on<OnFeedbackEvent>(_onGetFeedbackEvent);

  }

  _onGetFeedbackEvent(OnFeedbackEvent event, Emitter<FeedbackState> emitter) async {
    if (event.isLoading) {
      emitter(LoadingFeedbackState());
    }

    final result = await feedbackUsecase.call(event.mapPrompt);
    result.fold((l) {
      emitter(ErrorGenerateFeedbackState(l.errorMessage));
    }, (r) {
      var listFeedback = r.toList();
      Map<Map<String, String>, FeedbackResponse> qnaFeedbackMap = {};
      int index = 0;
      event.mapPrompt.forEach((question, answer){
        if (index < listFeedback.length) {
          qnaFeedbackMap[{question: answer}] = listFeedback[index];
        }
        index++;
      });

      emitter(SuccessGenerateFeedbackState(qnaFeedbackMap));
    });
  }
}