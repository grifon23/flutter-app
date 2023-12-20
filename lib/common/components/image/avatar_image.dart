import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.url});

  final String? url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: url != null
          ? Image.network(url!, height: 160.0, width: 160.0, fit: BoxFit.cover)
          : const Icon(
              Icons.account_circle,
              size: 160.0,
            ),
    );
  }
}
