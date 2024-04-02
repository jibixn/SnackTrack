import 'package:flutter/material.dart';
import 'colors.dart';

class GreetWidget extends StatelessWidget {
  const GreetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 60,
            height: 60,
            decoration:
                const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, User!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("Let's Grab your Food!",
                  style:
                      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
