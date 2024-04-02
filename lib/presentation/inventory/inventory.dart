import 'package:flutter/material.dart';

class ScreenInventory extends StatelessWidget {
  const ScreenInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SafeArea(
        child: Center(
          child: Text('Inventory'),
        ),
      ),
    );
  }
}
