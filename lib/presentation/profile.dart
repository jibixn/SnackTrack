import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 355,
          child: Stack(
            children: [
              Container(
                height: 300,
                width: MediaQuery.sizeOf(context).width,
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
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        SizedBox(width: 140),
                        Text('My Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 100),
                        Icon(
                          Icons.edit_square,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'User Name',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 260,
                  left: 20,
                  child: Container(
                      height: 90,
                      width: 320,
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
                            const SizedBox(width: 20),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('MONTHLY ORDER COUNT:',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    )),
                                Text('150',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Container(height: 70, width: 2, color: Colors.grey),
                            const SizedBox(width: 25),
                            const Column(
                              children: [
                                Text('TOTAL PRICE:',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    )),
                                Text('₹3300',
                                    style: TextStyle(
                                      fontSize: 32,
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
        const SizedBox(height: 20),
        const Row(children: [
          SizedBox(width: 20),
          Text('Recent Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ]),
        Center(
          child: SizedBox(
            height: 290,
            width: 330,
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
                                height: 80,
                                width: 380,
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
                                      height: 60,
                                      width: 60,
                                      decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    const SizedBox(width: 15),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dosa & Sambar',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                        ),
                                        Text('11/04/2024',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 92, 92, 92))),
                                        Text(
                                          '₹ 30',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
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
                                    height: 40,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 50, 50, 50),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: const Center(
                                      child: Text('BREAKFAST',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      )),
            ),
          ),
        ),
      ]),
    );
  }
}
