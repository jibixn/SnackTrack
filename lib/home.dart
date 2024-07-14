import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snack_track/Menu.dart';
import 'package:snack_track/db/funtions/cartFuntions.dart';
import 'package:snack_track/db/models/cart_model.dart';
import 'greet.dart';
import 'dart:convert';
import 'Menu.dart';

int trendingCount = 6;

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _MyWidgetState();
}



class _MyWidgetState extends State<ScreenHome> {
  String name ='';
  List menuItems=[];
  int Bflag=0;
  int Lflag=0;
  int Sflag=0;
  int Dflag=0;

  int _totalCount = 0, _catIndex = 0;
  num _totalPrice = 0;
  String _searchText = '';
  List NewMenuItems = [];
  
  
  List<dynamic>? _filteredMenuItems;

    @override
  initState() {
    super.initState();
    getAllItems();
    choose_menu('Breakfast');
    Bflag=1;
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



Future<void>  choose_menu(String cat) async {
    _totalCount=0;
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

  Widget Proceed(){
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: _totalCount > 0
          ? Center(
        child: Container(
          height: ScreenHeight * 0.08,
          width: ScreenWidth * 0.4,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 46, 125, 50),
            borderRadius: BorderRadius.all(Radius.circular(ScreenWidth * 0.056)),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                  onTap: () {
                    int n=_filteredMenuItems!.length;
                    for(int i=0;i<n;i++){
                      if(_filteredMenuItems![i]['count']>0){
                        final Item = cartModel(Id:_filteredMenuItems![i]['_id'].toString(),item:_filteredMenuItems![i]['name'].toString(), price: _filteredMenuItems![i]['price'].toString(), quantity: _filteredMenuItems![i]['count'].toString());
                        addItem(Item);
                      }
                    }                    
                    Navigator.of(context).pushNamed('/cart');
                  },
                  child: Text(
                    'Proceed ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenWidth * 0.0456,
                    ),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: ScreenWidth*0.055,
                ),
                  ],
                ),
              ],
            ),
          ),
        ),
            )
          : Container(),
    );
  }

  Widget MenuItemList(){
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        MediaQuery(
          data: MediaQueryData(size: screenSize),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.013),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.417),
                 
                ],
              ),
              SizedBox(height: screenSize.height * 0.006),
              
              SizedBox(height: screenSize.height * 0.013),
              Container(
                height: screenSize.height * 0.43,
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
                      height: screenSize.height * 0.4,
                      width: screenSize.width * 0.889,
                      child: Column(
                        children: [
                          
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
                                  shrinkWrap: true,                               
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
              
    
            ],
          ),
        ),
      ],
    );
  }


  
 @override
Widget build(BuildContext context) {  
  
  double ScreenWidth = MediaQuery.of(context).size.width;
  double ScreenHeight = MediaQuery.of(context).size.height;  
  return Scaffold(    
    body: SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children:[ Column(
            
            children: [
              SizedBox(
                height: ScreenHeight * 0.05,
              ),
              GreetWidget(),
              SizedBox(
                height: ScreenHeight * 0.05,
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        width: ScreenWidth * 0.2,
                        height: ScreenWidth * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            choose_menu('Breakfast');
                            setState(() {
                              Bflag = 1;
                              Lflag = 0;
                              Sflag = 0;
                              Dflag = 0;
                            });
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/breakfast.jpg',
                              width: ScreenWidth * 0.2,
                              height: ScreenWidth * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.005),
                      Text(
                        'Breakfast',
                        style: TextStyle(
                          fontWeight: Bflag == 1 ? FontWeight.w900 : FontWeight.bold,
                          fontSize: Bflag == 1 ? 15 : 14,
                          decoration: Bflag == 1 ? TextDecoration.underline : null,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        width: ScreenWidth * 0.2,
                        height: ScreenWidth * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            choose_menu('Lunch');
                            setState(() {
                              Bflag = 0;
                              Lflag = 1;
                              Sflag = 0;
                              Dflag = 0;
                            });
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/lunch.jpg',
                              width: ScreenWidth * 0.2,
                              height: ScreenWidth * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.005),
                      Text(
                        'Lunch',
                        style: TextStyle(
                          fontWeight: Lflag == 1 ? FontWeight.w900 : FontWeight.bold,
                          fontSize: Lflag == 1 ? 15 : 14,
                          decoration: Lflag == 1 ? TextDecoration.underline : null,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        width: ScreenWidth * 0.2,
                        height: ScreenWidth * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            choose_menu('Snacks');
                            setState(() {
                              Bflag = 0;
                              Lflag = 0;
                              Sflag = 1;
                              Dflag = 0;
                            });
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/snacks.jpeg',
                              width: ScreenWidth * 0.2,
                              height: ScreenWidth * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.005),
                      Text(
                        'Snacks',
                        style: TextStyle(
                          fontWeight: Sflag == 1 ? FontWeight.w900 : FontWeight.bold,
                          fontSize: Sflag == 1 ? 15 : 14,
                          decoration: Sflag == 1 ? TextDecoration.underline : null,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        width: ScreenWidth * 0.2,
                        height: ScreenWidth * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            choose_menu('Dinner');
                            setState(() {
                              Bflag = 0;
                              Lflag = 0;
                              Sflag = 0;
                              Dflag = 1;
                            });
                          },
                          child: ClipOval(
                            child: Image.asset(
                              'assets/dinner.webp',
                              width: ScreenWidth * 0.2,
                              height: ScreenWidth * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.005),
                      Text(
                        'Dinner',
                        style: TextStyle(
                          fontWeight: Dflag == 1 ? FontWeight.w900 : FontWeight.bold,
                          fontSize: Dflag == 1 ? 15 : 14,
                          decoration: Dflag == 1 ? TextDecoration.underline : null,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: ScreenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: ScreenWidth * 0.1),
                ],
              ),
              SizedBox(height: ScreenHeight * 0.008),
              Container(
                width: ScreenWidth * 0.917,
                height: ScreenHeight * 0.051,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(ScreenWidth * 0.042)),
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
              MenuItemList(),
              
            ],
          ),
          Positioned(
            top: ScreenHeight*0.8,
            left: ScreenWidth*0.3,
            child: Proceed(),
          )
          ]
        ),
      ),
    ),
  );
}  
}

