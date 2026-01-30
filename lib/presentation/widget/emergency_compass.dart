import 'package:flutter/material.dart';
import 'dart:math';

double rssiToAngle(int rssi, int minRssi, int maxRssi) {
  rssi = rssi.clamp(minRssi, maxRssi);
  final test = pi * (maxRssi - rssi) / (maxRssi - minRssi);
  print(" rssi: $rssi => angle: $test radians ");
  return test; // angle en radians
}

class CompassOverlay extends StatelessWidget {
  final double angle; // angle en radians

  const CompassOverlay({super.key, required this.angle});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      // laisse passer les touches
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Transform.rotate(
              angle: angle,
              child: Icon(
                Icons.arrow_upward,
                size: 80,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
