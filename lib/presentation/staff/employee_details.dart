import 'package:flutter/material.dart';
import 'package:snack_track/presentation/order/profile.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Profile(showEditButton: false),
          Positioned(
            bottom: 16.0,
            width: MediaQuery.of(context).size.width - 32.0,
            left: MediaQuery.of(context).size.width / 2 -
                (MediaQuery.of(context).size.width - 32.0) / 2,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to menu or perform action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 50, 50, 50),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'PLACE ORDER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
