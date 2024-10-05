import 'package:denkidsv4/components/my_button.dart';
import 'package:denkidsv4/components/my_gradient_text.dart';
import 'package:denkidsv4/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset('assets/BG.svg'),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat datang di ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              GradientText(
                "Denkids",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
                gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.pinkAccent]),
              )
            ],
          ),
          MyButton(
              text: "Ayo mulai!",
              onTap: () {
                Get.to(() => const VideoPage());
              })
        ],
      ),
    );
  }
}
