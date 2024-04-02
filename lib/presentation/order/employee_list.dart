import 'package:flutter/material.dart';

class ScreenEmployeeList extends StatelessWidget {
  const ScreenEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Emp List'),
        ),
      ),
    );
  }
}
