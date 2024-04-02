import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
        maxHeight: 300,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(5, (index) => const MenuTile())));
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          height: 300,
          width: 190,
          child: Stack(
            children: [
              Positioned(
                top: 70,
                child: Container(
                  width: 190,
                  height: 225,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 5)),
                    ],
                  ),
                  child: const Center(
                      child: Text(
                    'Dosa, Sambar\n&Chutney',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  )),
                ),
              ),
              Positioned(
                left: 20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              ),
              const Positioned(
                  top: 250,
                  left: 10,
                  child: Text(
                    '₹ 30',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  )),
              Positioned(
                  top: 230,
                  left: 125,
                  child: FloatingActionButton(
                    onPressed: () => null,
                    child: const Icon(Icons.add),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
