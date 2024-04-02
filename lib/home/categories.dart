import 'package:flutter/material.dart';
import 'package:snack_track/core/colors/colors.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Spacer(),
      Column(
        children: [
          CategoryTile(),
          SizedBox(height: 4),
          Text('Breakfast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
      Spacer(),
      Column(
        children: [
          CategoryTile(),
          SizedBox(height: 4),
          Text(
            'Lunch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Spacer(),
      Column(
        children: [
          CategoryTile(),
          SizedBox(height: 4),
          Text('Snacks', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      Spacer(),
      Column(
        children: [
          CategoryTile(),
          SizedBox(height: 4),
          Text('Dinner', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      Spacer(),
    ]);
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      height: 70,
      width: 70,
    );
  }
}
