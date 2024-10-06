import 'package:denkidsv4/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:get/get.dart';
import '../services/firestore.dart'; // Import the Firestore service

class QuizPage extends StatefulWidget {
  final String nameId; // Add nameId as a parameter
  final String age; // Add age as a parameter

  const QuizPage(
      {super.key,
      required this.nameId,
      required this.age}); // Require nameId and age

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List to store the answers
  List<bool?> answers = List<bool?>.filled(10, null);

  // Index to track the current question
  int currentQuestionIndex = 0;

  // Firestore service instance
  final FirestoreService _firestoreService = FirestoreService();

  // List of questions
  final List<String> questions = [
    "Gigi berlubang menyebabkan bau mulut",
    "Saya menyikat gigi dengan gerakan maju mundur untuk gigi bagian belakang",
    "Saya Menyikat gigi pagi sebelum sarapan dan malam sebelum tidur",
    "Saya rutin ke dokter gigi 6 bulan sekali",
    "Saya suka makan buah dan sayur",
    "Saya menyikat gigi dengan gerakan turun naik untuk gigi bagian depan",
    "Saya suka makan dan minum yang manis",
    "Gigi saya rusak karena jarang menjaga kebersihan gigi dan mulut",
    "Saya rajin menyikat gigi untuk menghindari gigi rusak",
    "Tidak menjaga kebersihan gigi dan mulut membuat gusi bengkak"
  ];

  // List of SVG image paths
  final List<String> images = [
    "assets/images/image1.svg",
    "assets/images/image2.svg",
    "assets/images/image4.svg",
    "assets/images/image6.svg",
    "assets/images/image3.svg",
    "assets/images/image2.svg",
    "assets/images/image7.svg",
    "assets/images/image8.svg",
    "assets/images/image5.svg",
    "assets/images/image1.svg",
  ];

  // Function to handle the submission of the quiz
  void _submitQuiz() async {
    String result = "Kerja Bagus ${widget.nameId}! Ini Jawaban kamu:\n\n";
    List<String> userAnswers = [];

    for (int i = 0; i < answers.length; i++) {
      String answerText = answers[i] == true ? "Yes" : "No";
      result += "${questions[i]}: $answerText\n";
      userAnswers.add(answerText);
    }

    // Prepare the data to send to Firestore
    Map<String, dynamic> quizData = {
      "name": widget.nameId,
      "age": widget.age,
      "answers": userAnswers,
      "timestamp": Timestamp.now()
    };

    // Save the quiz data to Firestore
    await _firestoreService.addQuizResult(quizData);
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightBlue.shade100,
            title: const Text(
              "Hebat!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: Text(result, style: const TextStyle(fontSize: 20)),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(() => WelcomePage());
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 22, color: Colors.blueAccent),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to navigate to the next question
  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _submitQuiz();
    }
  }

  // Function to navigate to the previous question
  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(
          'Hi ${widget.nameId}! Mari kita bermain quiz!',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'ComicSans',
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the image related to the current question
                  SvgPicture.asset(
                    images[currentQuestionIndex], // Load the SVG image
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Question ${currentQuestionIndex + 1}/${questions.length}:",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ComicSans',
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Wrap question text in a card with padding and rounded corners
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        questions[currentQuestionIndex],
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'ComicSans',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Answer options
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            "Iya",
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          value: true,
                          groupValue: answers[currentQuestionIndex],
                          onChanged: (bool? value) {
                            setState(() {
                              answers[currentQuestionIndex] = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text(
                            "Tidak",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                          value: false,
                          groupValue: answers[currentQuestionIndex],
                          onChanged: (bool? value) {
                            setState(() {
                              answers[currentQuestionIndex] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed:
                      currentQuestionIndex == 0 ? null : _previousQuestion,
                  child: const Text("Kembali", style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: answers[currentQuestionIndex] != null
                      ? _nextQuestion
                      : null,
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? "Selesai"
                        : "Lanjut",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
