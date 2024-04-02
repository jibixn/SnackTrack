import 'package:flutter/material.dart';
import 'categories.dart';
import 'greet.dart';
import 'menu.dart';

int trendingCount = 6;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(children: [
        GreetWidget(),
        SizedBox(
          height: 75,
        ),
        CategoriesWidget(),
        SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 40),
          Text(
            'Menu',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ]),
        SizedBox(height: 30),
        MenuWidget(),
      ])),
    );
  }
}
