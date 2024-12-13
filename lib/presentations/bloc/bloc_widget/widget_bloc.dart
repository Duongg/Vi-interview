import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vi_interview/presentations/bloc/bloc_widget/widget_event.dart';
import 'package:vi_interview/presentations/bloc/bloc_widget/widget_state.dart';

class WidgetBloc extends Bloc<WidgetEvent, WidgetJobState> {
  WidgetBloc() : super(JobOnboardingWidgetState()) {
    on<JobOnboardingWidgetEvent>((event, emit) => emit(JobOnboardingWidgetState()));
    on<JobQuestionWidgetEvent>((event, emit) => emit(JobQuestionWidgetState()));
  }
}