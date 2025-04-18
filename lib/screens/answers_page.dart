import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswersPage extends StatelessWidget {
  final String courseId; // Firestore doc ID
  final String courseName;
  final List<String> questions;
  final List<String> userAnswers;

  AnswersPage({
    required this.courseId,
    required this.courseName,
    required this.questions,
    required this.userAnswers,
  });

  Future<List<String>> _fetchCorrectAnswers() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId) // Use the actual document ID
          .get();

      if (!snapshot.exists) {
        throw Exception("Course not found");
      }

      List<dynamic> correctAnswers = snapshot['correctAnswers'];
      return correctAnswers.cast<String>();
    } catch (e) {
      print("Error fetching correct answers: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$courseName - Answers"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6FB7AE), Color(0xFFFFC288)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchCorrectAnswers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text("Error fetching correct answers"));
          }

          List<String> correctAnswers = snapshot.data ?? [];

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              String userAnswer = userAnswers[index];
              String correctAnswer = correctAnswers.length > index
                  ? correctAnswers[index]
                  : "Not Available";

              bool isCorrect = userAnswer.trim().toLowerCase() ==
                  correctAnswer.trim().toLowerCase();

              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6FB7AE), Color(0xFFFFC288)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q${index + 1}: ${questions[index]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your Answer:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Correct Answer:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          correctAnswer,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        isCorrect ? "Correct!" : "Incorrect",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? Colors.green[700] : Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
