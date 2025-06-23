import 'package:denkidsv4/components/my_button.dart';
import 'package:denkidsv4/components/my_gradient_text.dart';
import 'package:denkidsv4/pages/menu_page.dart'; // Changed import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

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
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SvgPicture.asset('assets/bg2.svg', width: 400),
              const SizedBox(height: 25),
              const Text(
                "Selamat datang di aplikasi pembelajaran kesehatan gigi untuk anak!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                "Mari belajar cara merawat gigi dengan cara yang menyenangkan!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              MyButton(
                text: "Mulai Sekarang!",
                onTap: () {
                  Get.to(() => const MenuPage()); // Changed navigation
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
