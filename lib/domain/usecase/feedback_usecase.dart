
import 'package:dartz/dartz.dart';
import 'package:vi_interview/domain/model/feedback_response.dart';
import 'package:vi_interview/domain/repository/job_content_repository.dart';
import 'package:vi_interview/domain/usecase/job_content_usecase.dart';

class FeedbackUsecase
    extends UseCase<List<FeedbackResponse>, Map<String, String>> {
  final AbstactJobContentRepository repository;

  FeedbackUsecase(this.repository);

  @override
  Future<Either<Failure, List<FeedbackResponse>>> call(
      Map<String, String> mapPrompt) async {
    final result = await repository.getFeedback(mapPrompt);
    return result.fold((l) => Left(l), (r) async {
      return Right(r);
    });
  }
}