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
  final List<String> _categories = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  final List<List<dynamic>> _menuItems = [
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
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: MediaQuery(
        data: MediaQueryData(size: screenSize),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.013),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.417),
                const Text(
                  'MENU',
                  style: TextStyle(
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.006),
            Container(
              width: screenSize.width * 0.917,
              height: screenSize.height * 0.051,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(screenSize.width * 0.042)),
                boxShadow: const [
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
            SizedBox(height: screenSize.height * 0.013),
            Container(
              height: screenSize.height * 0.639,
              width: screenSize.width * 0.944,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(screenSize.width * 0.042)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.013),
                  SizedBox(
                    height: screenSize.height * 0.626,
                    width: screenSize.width * 0.889,
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
                                    (i) => i == index ? 1 : 0,
                                  );
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
                                      margin: EdgeInsets.only(
                                          top: screenSize.height * 0.0052),
                                      height: screenSize.height * 0.0052,
                                      width: screenSize.width * 0.139,
                                      color:
                                          const Color.fromARGB(255, 50, 50, 50),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.013),
                        Expanded(
                          child: _filteredMenuItems == null ||
                                  _filteredMenuItems!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.height * 0.0385),
                                  child: Text(
                                    'No result found.',
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.061,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _filteredMenuItems!.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      SizedBox(
                                          height: screenSize.height * 0.009),
                                      SizedBox(
                                        height: screenSize.height * 0.109,
                                        width: screenSize.width * 0.889,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: screenSize.width * 0.111,
                                              child: Container(
                                                height:
                                                    screenSize.height * 0.109,
                                                width: screenSize.width * 0.777,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        screenSize.width *
                                                            0.056),
                                                  ),
                                                  boxShadow: const [
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
                                              right: screenSize.width * 0.003,
                                              bottom: 0,
                                              child: Container(
                                                height:
                                                    screenSize.height * 0.0448,
                                                width: screenSize.width * 0.320,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        screenSize.width *
                                                            0.056),
                                                  ),
                                                  color: const Color.fromARGB(
                                                      255, 50, 50, 50),
                                                ),
                                                child: _filteredMenuItems![
                                                            index][2] !=
                                                        0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
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
                                                          _filteredMenuItems![
                                                                          index]
                                                                      [2] <
                                                                  10
                                                              ? SizedBox(
                                                                  width: screenSize
                                                                          .width *
                                                                      0.023)
                                                              : Container(),
                                                          Text(
                                                            _filteredMenuItems![
                                                                    index][2]
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
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
                                                    width: screenSize.width *
                                                        0.236,
                                                    height: screenSize.height *
                                                        0.109,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: screenSize.width *
                                                          0.0278),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        _filteredMenuItems![
                                                            index][0],
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenSize.width *
                                                                  0.05,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Inter',
                                                        ),
                                                      ),
                                                      Text(
                                                        '₹ ${_filteredMenuItems![index][1]}',
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenSize.width *
                                                                  0.05,
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
            SizedBox(height: screenSize.height * 0.006),
            _totalCount > 0
                ? Center(
                    child: Container(
                      height: screenSize.height * 0.0765,
                      width: screenSize.width * 0.958,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenSize.width * 0.056)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: screenSize.width * 0.0417),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenSize.height * 0.0064),
                              Text(
                                '$_totalCount items',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Container(
                                height: screenSize.height * 0.0013,
                                width: screenSize.width * 0.583,
                                color: Colors.white,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontSize: screenSize.width * 0.0333,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    '₹ $_totalPrice',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenSize.width * 0.0556,
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
                            child: Text(
                              'Proceed >',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenSize.width * 0.0556,
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
      ),
    );
  }
}
