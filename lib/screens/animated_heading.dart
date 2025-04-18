import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextLiquidFill(
        text: 'My Courses',
        waveColor: Colors.blueAccent,
        boxBackgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        boxHeight: 100.0,
      ),
    );
  }
}
