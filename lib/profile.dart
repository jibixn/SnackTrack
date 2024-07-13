import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenWidth / 375; // Assuming 375 is the base width

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: screenHeight * 0.45,
            child: Stack(
              children: [
                Container(
                  height: screenHeight * 0.38,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 50, 50, 50),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(5, 3)),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.35),
                          Text('My Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 * scaleFactor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: screenWidth * 0.15),
                          const Icon(
                            Icons.edit_square,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Container(
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'User Name',
                        style: TextStyle(
                            fontSize: 24 * scaleFactor, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: screenHeight * 0.34,
                    left: screenWidth * 0.05,
                    child: Container(
                        height: screenHeight * 0.12,
                        width: screenWidth * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(children: [
                              SizedBox(width: screenWidth * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('MONTHLY ORDER COUNT:',
                                      style: TextStyle(
                                        fontSize: 10 * scaleFactor,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      )),
                                  Text('150',
                                      style: TextStyle(
                                        fontSize: 32 * scaleFactor,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                              SizedBox(width: screenWidth * 0.05),
                              Container(
                                  height: screenHeight * 0.08,
                                  width: 2,
                                  color: Colors.grey),
                              SizedBox(width: screenWidth * 0.07),
                              Column(
                                children: [
                                  Text('TOTAL PRICE:',
                                      style: TextStyle(
                                        fontSize: 10 * scaleFactor,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      )),
                                  Text('₹3300',
                                      style: TextStyle(
                                        fontSize: 32 * scaleFactor,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                            ]),
                          ],
                        )))
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(children: [
            SizedBox(width: screenWidth * 0.05),
            Text('Recent Orders',
                style: TextStyle(
                  fontSize: 20 * scaleFactor,
                  fontWeight: FontWeight.w700,
                )),
          ]),
          Center(
            child: SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth * 0.9,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(
                    10,
                    (index) => Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: screenHeight * 0.1,
                                  width: screenWidth * 0.9,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 226, 226, 226),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                ),
                                Positioned(
                                    top: 8,
                                    left: 10,
                                    child: Row(children: [
                                      Container(
                                        height: screenWidth * 0.15,
                                        width: screenWidth * 0.15,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      SizedBox(width: screenWidth * 0.04),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dosa & Sambar',
                                            style: TextStyle(
                                                fontSize: 18 * scaleFactor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Inter'),
                                          ),
                                          Text('11/04/2024',
                                              style: TextStyle(
                                                  fontSize: 10 * scaleFactor,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 92, 92, 92))),
                                          Text(
                                            '₹ 30',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20 * scaleFactor,
                                                color: Color.fromARGB(
                                                    255, 50, 50, 50)),
                                          ),
                                        ],
                                      ),
                                    ])),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.25,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      child: Center(
                                        child: Text('BREAKFAST',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14 * scaleFactor)),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),
                          ],
                        )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
