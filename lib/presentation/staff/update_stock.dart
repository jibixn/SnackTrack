import 'package:flutter/material.dart';

class UpdateStock extends StatelessWidget {
  const UpdateStock({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String itemName = 'Dosa & Sambar';

    return Scaffold(
        body: SafeArea(
      child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(children: [
            Container(
              height: screenHeight * 0.35,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(5, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox()
                    ],
                  ),
                  SizedBox(
                    width: screenWidth * 0.132,
                  ),
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(itemName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.055,
                    screenHeight * 0.295, screenWidth * 0.055, 0),
                child: Container(
                    height: screenHeight * 0.525,
                    width: screenWidth * 0.89,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 10),
                        width: screenWidth * 0.8,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: '\t\t\t\tStock',
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide.none),
                            fillColor: Colors.black12,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        width: screenWidth * 0.8,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: '\t\t\t\tProduction Date',
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        width: screenWidth * 0.8,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: '\t\t\t\tExpiry Date',
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Submit button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 50, 50, 50),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          child: const Center(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18)
                    ])))
          ])),
    ));
  }
}
