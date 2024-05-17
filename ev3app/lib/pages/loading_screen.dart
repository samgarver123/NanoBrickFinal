import 'package:ev3app/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, Key? loading_key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust animation duration
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500), // Adjust animation duration
          pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
            opacity: animation,
            child: const HomeScreen(), // Navigate to HomeScreen
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: const Image(
              image: AssetImage('assets/Logo_Lego_Mindstorms_EV3.png'),
            ),
          ),
        ),
      ),
    );
  }
}
