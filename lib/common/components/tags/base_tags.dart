import 'package:flutter/material.dart';

class BaseTag extends StatelessWidget {
  const BaseTag({super.key, required this.tag});

  final String tag;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Colors.white,
            width: 1.0), // Встановлення колір та ширина обводки
        borderRadius: BorderRadius.circular(4.0), // Радіус кутів обводки
      ),
      label: Text(tag),
      // Інші параметри стилів для Chip, якщо потрібно
    );
  }
}
