import 'dart:async';

import 'package:covid_19_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WorldStates(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (
                BuildContext context,
                Widget? child,
              ) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },

              // width: 200,
              // height: 200,
              child: const Center(
                child: Image(
                  image: AssetImage('assets/virus.png'),
                  // width: 200,
                  // height: 200,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            const Text(
              "Covid-19\nTracker App",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
