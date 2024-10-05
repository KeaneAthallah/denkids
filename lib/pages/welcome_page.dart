import 'package:denkidsv4/components/my_button.dart';
import 'package:denkidsv4/components/my_gradient_text.dart';
import 'package:denkidsv4/components/my_text_field.dart';
import 'package:denkidsv4/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const GradientText(
            "Denkids",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            gradient:
                LinearGradient(colors: [Colors.blueAccent, Colors.pinkAccent]),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/bg2.svg',
                width: 400,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Nama:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextfield(
                  hintText: "", obscureText: false, controller: nameController),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Umur:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextfield(
                  hintText: "", obscureText: false, controller: ageController),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                  text: "Mulai quiz!",
                  onTap: () {
                    Get.to(() => QuizPage(
                          nameId: nameController.text,
                          age: ageController.text,
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
