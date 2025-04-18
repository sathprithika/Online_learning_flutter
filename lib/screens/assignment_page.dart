import 'package:flutter/material.dart';
import 'answers_page.dart';

class AssignmentPage extends StatefulWidget {
  final String courseId;
  final String courseName;
  final List<String> questions;

  AssignmentPage({
    required this.courseId,
    required this.courseName,
    required this.questions,
  });

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  late List<TextEditingController> answerControllers;

  @override
  void initState() {
    super.initState();
    answerControllers =
        List.generate(widget.questions.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitAnswers() {
    List<String> userAnswers = answerControllers
        .map((controller) => controller.text.trim())
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnswersPage(
          courseId: widget.courseId,
          courseName: widget.courseName,
          questions: widget.questions,
          userAnswers: userAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${widget.courseName} - Assignment"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6FB7AE), Color(0xFFFFC288)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: ListView.builder(
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500 + index * 100),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${index + 1}: ${widget.questions[index]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 6, color: Colors.black45),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: answerControllers[index],
                    style: const TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Type your answer here...",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.tealAccent),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitAnswers,
        label: const Text(
          "Submit",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.send_rounded),
        backgroundColor: Colors.tealAccent.shade700,
      ),

    );
  }
}
