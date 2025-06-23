import 'package:denkidsv4/components/my_button.dart';
import 'package:denkidsv4/components/my_gradient_text.dart';
import 'package:denkidsv4/pages/identification_page.dart';
import 'package:denkidsv4/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isIdentificationComplete = false;
  String userName = "";
  String userAge = "";

  // Callback function to handle identification completion
  void onIdentificationComplete(String name, String age) {
    setState(() {
      isIdentificationComplete = true;
      userName = name;
      userAge = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const GradientText(
          "Denkids",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.pinkAccent],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Welcome illustration
              SvgPicture.asset('assets/bg2.svg', width: 300, height: 200),

              const SizedBox(height: 40),

              // Welcome text
              const Text(
                "Selamat datang!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              const Text(
                "Mari kita mulai petualangan belajar tentang kesehatan gigi!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              // Status indicator if identification is complete
              if (isIdentificationComplete)
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Halo $userName! Siap untuk belajar?",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

              // First button - Identification
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isIdentificationComplete
                        ? Colors.green.shade400
                        : Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Get.to(
                      () => IdentificationPage(
                        onComplete: onIdentificationComplete,
                        currentName: userName,
                        currentAge: userAge,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isIdentificationComplete
                            ? Icons.edit
                            : Icons.person_add,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isIdentificationComplete
                            ? "Edit Identitas"
                            : "Isi Identitas",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Second button - Video (disabled until identification is complete)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isIdentificationComplete
                        ? Colors.pinkAccent
                        : Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: isIdentificationComplete ? 5 : 0,
                  ),
                  onPressed: isIdentificationComplete
                      ? () {
                          Get.to(
                            () =>
                                VideoPage(userName: userName, userAge: userAge),
                          );
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        color: isIdentificationComplete
                            ? Colors.white
                            : Colors.grey.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Tonton Video",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isIdentificationComplete
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Helper text
              if (!isIdentificationComplete)
                const Text(
                  "Silakan isi identitas terlebih dahulu untuk melanjutkan",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
