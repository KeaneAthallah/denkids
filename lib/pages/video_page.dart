import 'package:denkidsv4/components/my_button.dart';
import 'package:denkidsv4/pages/welcome_page.dart';
import 'package:denkidsv4/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String? userName;
  final String? userAge;

  const VideoPage({super.key, this.userName, this.userAge});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  bool videoCompleted = false; // Track video completion

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/denkids.mp4',
    );

    _videoPlayerController.addListener(() {
      // Check if video has finished playing
      if (_videoPlayerController.value.position >=
          _videoPlayerController.value.duration) {
        if (!videoCompleted) {
          setState(() {
            videoCompleted = true;
          });
        }
      }

      // Original logic
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      }
    });
  }

  @override
  void dispose() {
    // Stop and dispose video when leaving the page
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.pause();
    }
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // Pause video when page becomes inactive (e.g., navigating away)
    if (_videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
    super.deactivate();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  void _onQuizButtonPressed() {
    if (!videoCompleted) {
      // Show a message if video is not completed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan tonton video sampai selesai terlebih dahulu!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Stop video before navigating
    if (_videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }

    // Navigate to quiz if user data is available, otherwise to welcome page
    if (widget.userName != null && widget.userAge != null) {
      Get.to(() => QuizPage(nameId: widget.userName!, age: widget.userAge!));
    } else {
      Get.to(() => WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Animasi Denkids",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 30),
          // Video container with controlled height
          Container(
            height: 550,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FutureBuilder<bool>(
                future: started(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data ?? false) {
                    return AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    );
                  } else {
                    return Container(
                      color: Colors.black12,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text(
                              'Memuat video...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Column(
            children: [
              // Show different button styles based on video completion
              videoCompleted
                  ? MyButton(text: "Ayo quiz!", onTap: _onQuizButtonPressed)
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Ayo quiz! (Tonton video sampai selesai)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
