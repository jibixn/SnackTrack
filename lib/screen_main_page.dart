import 'package:flutter/material.dart';
import 'home.dart';
import 'inventory.dart';
import 'bottom_nav.dart';
import 'employee_list.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
    const ScreenHome(),
    const ScreenEmployeeList(),
    const ScreenInventory(),
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
