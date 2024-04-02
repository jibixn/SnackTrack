import 'package:flutter/material.dart';
import 'colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) {
        return Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: BottomNavigationBar(
                  currentIndex: newIndex,
                  onTap: (index) {
                    indexChangeNotifier.value = index;
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color.fromARGB(255, 50, 50, 50),
                  selectedIconTheme:
                      const IconThemeData(color: backgroundColor),
                  unselectedIconTheme:
                      const IconThemeData(color: backgroundColor),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 40,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Order',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      label: 'Inventory',
                    ),
                  ])),
        );
      },
    );
  }
}
