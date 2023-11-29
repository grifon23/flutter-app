import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final double? height;
  final Function() onTap;
  const ImageButton(
      {super.key, required this.imagePath, this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 1),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: height,
        ),
      ),
    );
  }
}
