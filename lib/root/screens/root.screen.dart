import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: Center(child: Text('Root screen'))),
    );
  }
}
