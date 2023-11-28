import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final String texContent;
  const PrimaryButton({super.key, this.onTap, required this.texContent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            texContent,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
