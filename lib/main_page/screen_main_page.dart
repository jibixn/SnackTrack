import 'package:flutter/material.dart';
import 'package:snack_track/presentation/home/home.dart';
import 'package:snack_track/presentation/inventory/inventory.dart';
import 'package:snack_track/presentation/main_page/widgets/bottom_nav.dart';
import 'package:snack_track/presentation/order/employee_list.dart';

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
