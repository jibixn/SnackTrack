import 'package:flutter/material.dart';

class ScreenInventory extends StatefulWidget {
  const ScreenInventory({super.key});

  @override
  State<ScreenInventory> createState() => _ScreenInventoryState();
}

class _ScreenInventoryState extends State<ScreenInventory> {
  int _totalCount = 0, _catIndex = 0, _menuCount = 12;
  num _totalPrice = 0;
  String _searchText = '';
  List<int> _categoryIndex = [1, 0, 0, 0];
  List<String> _categories = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  List<List<dynamic>> _menuItems = [
    // Breakfast category
    [
      ['Dosa & Sambar', 40, 0],
      ['Idli', 30, 0],
      ['Puutu & Kadala', 50, 0],
    ],

    // Lunch category
    [
      ['Rice', 40, 0],
      ['Curry', 30, 0],
      ['Roti', 50, 0],
    ],

    // Snacks category
    [
      ['Samosa', 40, 0],
      ['Puffs', 30, 0],
      ['Bonda', 50, 0],
    ],

    // Dinner category
    [
      ['Al Faham', 40, 0],
      ['Roti', 30, 0],
      ['Noodles', 50, 0],
    ],
  ];

  List<dynamic>? _filteredMenuItems;

  @override
  void initState() {
    super.initState();
    _filteredMenuItems = [];
    _filteredMenuItems!.addAll(_menuItems[0]);
  }

  void updateFilteredItems(String query) {
    setState(() {
      _filteredMenuItems = _menuItems[_catIndex]
          .where((item) =>
              item[0].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (_filteredMenuItems!.isEmpty) {
        _filteredMenuItems = null; // Set to null if no results found
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 150),
              Text(
                'MENU',
                style: TextStyle(
                  color: Color.fromARGB(255, 50, 50, 50),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            width: 330,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
                updateFilteredItems(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 500,
            width: 340,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 489,
                  width: 320,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          _categories.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _catIndex = index;
                                _categoryIndex = List.generate(
                                    _categories.length,
                                    (i) => i == index ? 1 : 0);
                                updateFilteredItems(_searchText);
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: _categoryIndex[index] == 1
                                        ? Colors.black
                                        : Colors.grey,
                                    fontWeight: _categoryIndex[index] == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (_categoryIndex[index] == 1)
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    height: 2,
                                    width: 50,
                                    color:
                                        const Color.fromARGB(255, 50, 50, 50),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: _filteredMenuItems == null ||
                                _filteredMenuItems!.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  'No result found.',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredMenuItems!.length,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    const SizedBox(height: 7),
                                    SizedBox(
                                      height: 85,
                                      width: 320,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 40,
                                            child: Container(
                                              height: 85,
                                              width: 279,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 0,
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 1,
                                            bottom: 0,
                                            child: Container(
                                              height: 35,
                                              width: 112.7,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                color: Color.fromARGB(
                                                    255, 50, 50, 50),
                                              ),
                                              child: _filteredMenuItems![index]
                                                          [2] !=
                                                      0
                                                  ? Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _filteredMenuItems![
                                                                  index][2]--;
                                                              _totalCount--;
                                                              _totalPrice -=
                                                                  _filteredMenuItems![
                                                                      index][1];
                                                            });
                                                          },
                                                        ),
                                                        Text(
                                                          _filteredMenuItems![
                                                                  index][2]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        _filteredMenuItems![
                                                                    index][2] <
                                                                10
                                                            ? const SizedBox(
                                                                width: 8.3)
                                                            : Container(),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _filteredMenuItems![
                                                                  index][2]++;
                                                              _totalCount++;
                                                              _totalPrice +=
                                                                  _filteredMenuItems![
                                                                      index][1];
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _filteredMenuItems![
                                                              index][2] = 1;
                                                          _totalCount++;
                                                          _totalPrice +=
                                                              _filteredMenuItems![
                                                                  index][1];
                                                        });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                50, 50, 50),
                                                      ),
                                                      child: const Text(
                                                        'ADD',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 85,
                                                  height: 85,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      _filteredMenuItems![index]
                                                          [0],
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Inter',
                                                      ),
                                                    ),
                                                    Text(
                                                      '₹ ${_filteredMenuItems![index][1]}',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          _totalCount > 0
              ? Center(
                  child: Container(
                    height: 60,
                    width: 345,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 50, 50, 50),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              '$_totalCount items',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Container(
                              height: 1,
                              width: 210,
                              color: Colors.white,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Amount: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  '₹ $_totalPrice',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // Handle proceed action
                          },
                          child: const Text(
                            'Proceed >',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}