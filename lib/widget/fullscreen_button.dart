import 'package:flutter/material.dart';

class FullScreenButton extends StatelessWidget {
  final String name;
  final Future<void> Function(BuildContext context) function;
  const FullScreenButton({
    super.key,
    required this.name,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(context),
      style: ElevatedButton.styleFrom(
        elevation: 6,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: SizedBox(
        width: 450,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
