// import 'package:flutter/material.dart';

// class QuizPage extends StatefulWidget {
//   final String nameId;
//   const QuizPage({super.key, required this.nameId});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   // List to store the answers
//   List<bool?> answers = [
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//   ]; // Adding 2 more for new questions

//   // Index to track the current question
//   int currentQuestionIndex = 0;

//   // List of questions
//   final List<String> questions = [
//     "Gigi berlubang menyebabkan bau mulut",
//     "Saya menyikat gigi dengan gerakan maju mundur untuk gigi bagian belakang",
//     "Saya Menyikat gigi pagi sebelum sarapan dan malam sebelum tidur",
//     "Saya rutin ke dokter gigi 6 bulan sekali",
//     "Saya suka makan buah dan sayur",
//     "Saya menyikat gigi dengan gerakan turun naik untuk gigi bagian depan",
//     "Saya suka makan dan minum yang manis",
//     "Gigi saya rusak karena jarang menjaga kebersihan gigi dan mulut",
//     "Saya rajin menyikat gigi untuk menghindari gigi rusak",
//     "Tidak menjaga kebersihan gigi dan mulu membuat gusi bengkak"
//   ];

//   // Function to handle the submission of the quiz
//   void _submitQuiz() {
//     String result = "Hasil Quiz: \n";
//     for (int i = 0; i < answers.length; i++) {
//       result += "${questions[i]}: ${answers[i] == true ? "Ya" : "Tidak"}\n";
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Hasil Quiz"),
//           content: Text(result),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Function to navigate to the next question
//   void _nextQuestion() {
//     if (currentQuestionIndex < questions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//       });
//     } else {
//       _submitQuiz();
//     }
//   }

//   // Function to navigate to the previous question
//   void _previousQuestion() {
//     if (currentQuestionIndex > 0) {
//       setState(() {
//         currentQuestionIndex--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Halo Selamat Datang ${widget.nameId}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Pertanyaan ${currentQuestionIndex + 1}/${questions.length}:",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Text(questions[currentQuestionIndex]),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: RadioListTile<bool>(
//                     title: const Text("Ya"),
//                     value: true,
//                     groupValue: answers[currentQuestionIndex],
//                     onChanged: (bool? value) {
//                       setState(() {
//                         answers[currentQuestionIndex] = value;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: RadioListTile<bool>(
//                     title: const Text("Tidak"),
//                     value: false,
//                     groupValue: answers[currentQuestionIndex],
//                     onChanged: (bool? value) {
//                       setState(() {
//                         answers[currentQuestionIndex] = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: _previousQuestion,
//                   child: const Text("Sebelumnya"),
//                 ),
//                 ElevatedButton(
//                   onPressed: answers[currentQuestionIndex] != null
//                       ? _nextQuestion
//                       : null, // Disable button if no answer is selected
//                   child: Text(currentQuestionIndex == questions.length - 1
//                       ? "Submit"
//                       : "Berikutnya"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }