import 'package:flutter/material.dart';
import 'package:snack_track/cart.dart';

import 'home.dart';
import 'profile.dart';
import 'bottom_nav.dart';
import 'Menu.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
     ScreenHome(),     
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) => _pages[index],
        ),
        
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
      
    );
  }
}
