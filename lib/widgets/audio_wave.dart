import 'dart:math';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({super.key});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  final Random _random = Random();

  final List<double> _bars =
      List.generate(32, (_) => 10);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 350,
      ),
    );

    _controller.addListener(() {

      if (_controller.isCompleted) {
        _controller.repeat();
      }

      setState(() {

        for (int i = 0;
            i < _bars.length;
            i++) {

          _bars[i] =
              8 +
              _random.nextDouble() * 45;
        }
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBar(double height) {

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
      width: 4,
      height: height,
      margin:
          const EdgeInsets.symmetric(
        horizontal: 1,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(4),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [

            Color(0xFF4B00FF),
            Color(0xFF8A2BE2),
            Color(0xFF00E5FF),
          ],
        ),
        boxShadow: const [

          BoxShadow(
            color: Color(0xFF8A2BE2),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 280,
      height: 70,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children:
            _bars.map(_buildBar).toList(),
      ),
    );
  }
}