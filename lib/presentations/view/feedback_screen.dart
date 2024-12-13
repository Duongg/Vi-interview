import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:vi_interview/presentations/bloc/bloc_feedback/feedback_bloc.dart';
import 'package:vi_interview/presentations/bloc/bloc_feedback/feedback_state.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Feedback",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: "RobotoMono",
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: BlocBuilder<FeebackBloc, FeedbackState>(
          builder: (context, state) {
            if (state is InitialFeedbackState) {
              return Container(
                color: Colors.white,
              );
            } else if (state is LoadingFeedbackState) {
              return const Center(
                child: SpinKitThreeBounce(
                  color: Colors.blue,
                ),
              );
            } else if (state is SuccessGenerateFeedbackState) {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: state.qnaFeedbackMap.entries.map((qnaEntry) {
                    return Card(
                      elevation: 4,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: qnaEntry.key.entries.map((qna){
                          return ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Question:",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                                  ),
                                  Text(qna.key,
                                      style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                                ]),
                            trailing:
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  qnaEntry.value.isExpanded = !qnaEntry.value.isExpanded;
                                });
                              },
                              child: Icon(
                                qnaEntry.value.isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                            ),
                            subtitle:
                            qnaEntry.value.isExpanded ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text("Your answer:",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text(qna.value,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 10),
                                const Text("AI Feedback: ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Text("Rating: ${qnaEntry.value.rating}",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Text("Feedback: ${qnaEntry.value.feedback}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 6),
                                Text("Correct Answer: ${qnaEntry.value.correctAnswer}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ) : SizedBox.shrink()
                          );

                        }).toList(),
                      ),
                      );
                  }).toList(),
                );
              } else {
              return const Text(
                "Oops! Please answer the question by press Start Answer to get the feedback",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              );
            }
          },
        ),
      )
    );
  }
}
