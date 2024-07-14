import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snack_track/db/funtions/cartFuntions.dart';
import 'package:snack_track/db/models/cart_model.dart';
import 'package:http/http.dart' as http;



class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin{
  int _totalCount = 0;
  num _totalPrice = 0;
  Box<cartModel> cartBox = Hive.box<cartModel>('cart_db');
  List<cartModel> cartModelList = ([]);
  
  List<Map<String, dynamic>> items = [];


void initializeCartBox() {
   cartModelList = cartBox.values.toList(); 
}

@override
  void initState() {
    super.initState();
    calcTotal();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }


//Sliding Button Funtions start here.
late AnimationController _controller = AnimationController(vsync: this);
  bool _isCompleted = false;
  
  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta! / 200;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.value >= 0.5) {
      _controller.forward(from: _controller.value);
      setState(() {        
        sendOrder();
        // Navigator.of(context).pushNamed('/home');
      });
      
    } else {
      _controller.reverse(from: _controller.value);
      setState(() {
        _isCompleted = false;
      });
     
    }
  }

  //Sliding Buttton Funtions end here.


Future<void> sendOrder() async {
    
    int n=cartModelList.length;    
    for (int i = 0; i < n; i++) {
        items.add({
          "menu": cartModelList[i].Id,
          "quantity": cartModelList[i].quantity
        });
    }

    String APIurl = "http://localhost:3000/api/Addorders";

    try {
      Map<String, dynamic> jsonData = {
        "items": items
      };

      
      final response = await http.post(Uri.parse(APIurl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(jsonData))      ;
      var jsonResponse = json.decode(response.body);
      print(response.statusCode);
      print(jsonResponse);
      if (response.statusCode == 201) {
         jsonResponse = json.decode(response.body);       
        _isCompleted = true;        
        deleteCart();
        Navigator.of(context).pushNamed('/home');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text('Unable to add order, Try Again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('An error occurred. Please try again later.$error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }





void calcTotal() {
    initializeCartBox();
    _totalPrice = 0; 
    int n=cartModelList.length;    
    for(int i=0;i<n;i++){ 
      _totalPrice += (int.parse(cartModelList[i].quantity) * int.parse(cartModelList[i].price));
    }  
    
  }
  

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight*0.1,
        title: Text(
                'Cart',
                style: TextStyle(
                  fontSize: screenWidth*0.1,
                  fontWeight: FontWeight.bold
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children:[ Column(
            children: [
              SizedBox(
                height: screenHeight*0.025,
              ),
              
              ValueListenableBuilder<List<cartModel>>(
                valueListenable: cartItemsNotifier,
                builder: (BuildContext ctx, List<cartModel> cartItems, Widget? child) {
                  return Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: LimitedBox(
                      maxHeight: screenHeight * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          final data = cartItems[index];
                          
                          return Padding(
                            
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₹' + data.price.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Qty: ' + data.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: cartItems.length,
                      ),
                    ),
                  );
                },
              ),
              
              Center(
                child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return GestureDetector(
              onHorizontalDragUpdate: _handleDragUpdate,
              onHorizontalDragEnd: _handleDragEnd,
              child: Container(
                height: screenHeight*0.075,
                width: screenWidth*0.65,
                decoration: BoxDecoration(
                  color: _isCompleted?Colors.green:Colors.grey,
                  borderRadius: BorderRadius.circular(screenWidth*0.1),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: _controller.value * screenWidth*0.65,
                      child: Container(
                        height: screenWidth*0.155,
                        width: screenWidth*0.155,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(_isCompleted?1:0.75),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _isCompleted ? 'Order Completed!' : 'Slide to Proceed | ₹$_totalPrice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight*0.02,
            left: screenWidth*0.78,
            child: Container( 
                              height: screenHeight*0.055,
                              width: screenWidth*0.18,
                              // margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: TextButton(
              onPressed: () {
                setState(() {
                  deleteCart();
                  Navigator.of(context).pop();
                });
                
              },
              
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                
                // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20),
                // ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      size: screenHeight*0.02,
                    )
                  ],
                ),
              ),
                              ),
                            ),
          
          )
          ]
        ),
      ),
    );
  }
}
