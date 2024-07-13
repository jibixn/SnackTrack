import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _totalCount = 0, _catIndex = 0;
  num _totalPrice = 0;
  String _searchText = '';
  List NewMenuItems = [];

  List<int> _categoryIndex = [1, 0, 0, 0];
  final List<String> _categories = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  List<dynamic>? _filteredMenuItems;

  choose_menu(String cat) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/getmenu'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        NewMenuItems = jsonResponse['menu']
            .where((item) => item['category'] == cat)
            .toList();

        
        for (var item in NewMenuItems) {
          item['count'] = item['count'] ?? 0;
        }

        if (NewMenuItems.isNotEmpty) {
          setState(() {
            _filteredMenuItems = NewMenuItems;
          });
        }
      } else {
        print('bad response : ${response.statusCode}');
      }
    } catch (e) {
      print('exception entered : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    choose_menu('Breakfast');
  }

  void updateFilteredItems(String query) {
    setState(() {
      _filteredMenuItems = NewMenuItems
          .where((item) =>
              item['name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (_filteredMenuItems!.isEmpty) {
        _filteredMenuItems = null; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MediaQuery(
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
                                        choose_menu(_categories[index]);
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
                                                      height: screenSize.height * 0.109,
                                                      width: screenSize.width * 0.777,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(screenSize.width * 0.056),
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
                                                    right: screenSize.width * 0.015,
                                                    bottom: screenSize.height*0.0075,
                                                    child: Container(
                                                      height: screenSize.height * 0.0448,
                                                      width: screenSize.width * 0.30,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(screenSize.width * 0.036),
                                                        ),
                                                        color: const Color.fromARGB(255, 50, 50, 50),
                                                      ),
                                                      child: _filteredMenuItems![index]['count'] != null && _filteredMenuItems![index]['count'] > 0
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(
                                                                    Icons.remove,
                                                                    color: Colors.white,
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _filteredMenuItems![index]['count']--;
                                                                      _totalCount--;
                                                                      _totalPrice -= _filteredMenuItems![index]['price'];
                                                                    });
                                                                  },
                                                                ),
                                                                _filteredMenuItems![index]['count'] < 10
                                                                    ? SizedBox(width: screenSize.width * 0.023)
                                                                    : Container(),
                                                                Text(
                                                                  _filteredMenuItems![index]['count'].toString(),
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w800,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                    Icons.add,
                                                                    color: Colors.white,
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _filteredMenuItems![index]['count']++;
                                                                      _totalCount++;
                                                                      _totalPrice += _filteredMenuItems![index]['price'];
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            )
                                                          : ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  _filteredMenuItems![index]['count'] = 1;
                                                                  _totalCount++;
                                                                  _totalPrice += _filteredMenuItems![index]['price'];
                                                                });
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: const Color.fromARGB(255, 50, 50, 50),
                                                              ),
                                                              child: const Text(
                                                                'ADD',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w700,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: screenSize.width * 0.236,
                                                          height: screenSize.height * 0.109,
                                                          decoration: const BoxDecoration(
                                                            color: Colors.grey,
                                                            shape: BoxShape.circle,
                                                          ),
                                                        ),
                                                        SizedBox(width: screenSize.width * 0.0278),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              _filteredMenuItems![index]['name'],
                                                              style: TextStyle(
                                                                fontSize: screenSize.width * 0.0556,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                            ),
                                                            SizedBox(height: screenSize.height * 0.0045),
                                                            Text(
                                                              '\ ₹${_filteredMenuItems![index]['price']}',
                                                              style: TextStyle(
                                                                fontSize: screenSize.width * 0.0486,
                                                                color: Colors.black,
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
                                            SizedBox(height: screenSize.height * 0.013),
                                            
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
                  _totalCount > 0
          ? Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Container(
            height: screenSize.height * 0.0865,
            width: screenSize.width * 0.958,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 50, 50, 50),
              borderRadius: BorderRadius.all(Radius.circular(screenSize.width * 0.056)),
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
                
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenSize.height * 0.0064),
                      Text(
                        '$_totalCount items',
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                            height: screenSize.height*0.005,
                          ),
                      Container(
                        height: screenSize.height * 0.0008,
                        width: screenSize.width * 0.483,
                        color: Colors.white,
                      ),
                      SizedBox(
                            height: screenSize.height*0.005,
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
                              fontSize: screenSize.width * 0.0456,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Text(
                          'Proceed ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.0556,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_circle_right,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: screenSize.width*0.03,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
            )
          : Container(),
        
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

