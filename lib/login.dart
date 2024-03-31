import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key ? key}) : super(key : key);

  @override
  State<LoginScreen> createState() => _LoginscreenState();
}




class _LoginscreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? check = true;
  var temp;

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    String APIurl = "endpoint";

    try {
      Map<String,dynamic> jsonData = {
        'username':username,
        'password':password
      };

      print(temp);
      final response = await http.post(Uri.parse(APIurl),
      headers: {'Content-Type':'application/json'},
          body: json.encode(jsonData));
      temp = response;
      
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);

        String token = jsonResponse['token'];
        
         Navigator.of(context).pushNamed('/home');
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text('Invalid username or password'),
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
      print(temp);
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

  @override
  Widget build(BuildContext context) {
    double ScreenWidth=MediaQuery.of(context).size.width;
    double ScreenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(

        child: Container(
          width :double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              //LOGIN_HEADING
              
          
              //USERNAME
              Stack(
                clipBehavior: Clip.none,
                children: [
                  
                  Container(
                  width: ScreenWidth*0.9,
                  height: ScreenHeight*0.4,
                  decoration: BoxDecoration(
                    color:Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 1,
                        offset: Offset(0.0,4.0),                        
                        spreadRadius: 1
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 15,
                        offset: Offset(-4.0,-4.0),                        
                        spreadRadius: 1
                      ),
                      
                    ]
                  ),
                  
                  child: Column(
                    children: [
                      Container(
                        
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: '\t\t\t\tUSERNAME',
                            hintStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide.none
                            ),
                            fillColor: Colors.black12,
                            filled: true,
                          ),
                        ),
                        padding: EdgeInsets.only(top: 60,bottom: 10),
                        width: ScreenWidth*0.8,
                      ),
                      Container(
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: '\t\t\t\tPASSWORD',
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),      
                          borderSide: BorderSide.none                
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        
                      ),
                    ),    
                    padding: EdgeInsets.only(top: 20,bottom: 10),            
                    width: ScreenWidth*0.8,
                  ),
                  Container(
                    width: 585,
                    child: Row(                
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                      children: [
                        Container(
                      child: Row(                  
                        children: [
                          Text(
                            "REMEMBER ME",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Checkbox(value: check,onChanged:(neww){
                            setState((){
                              
                              check=neww;
                            });
                          },),
                        ],
                      ), 
                      padding: EdgeInsets.only(bottom:50,left: 10),                            
                    ),
                        Container(
                          child:InkWell(
                            onTap: (){},  
                            child: 
                            Text(
                              'FORGOT PASSWORD?',
                            style: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic
                              ),
                            textAlign:TextAlign.right,
                            )
                            ),
                          
                        ),
                        
                      ],
                    ),
                  ),
                  
                  
                  
                  
                  
                    ],
                  ),
                                  ),
                //LOGIN_BUTTON
                Positioned(
                  
                  left: ((ScreenWidth*0.9)-125)/2,
                  top:(ScreenHeight*0.4-25),
                  child: Container(
                    
                    width: 125,
                    height: 50,
                    child: ElevatedButton(                
                      onPressed: (){    
                        //login();              
                        Navigator.of(context).pushNamed('/home');
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                      ),
                      ),
                    style: ElevatedButton.styleFrom(                
                      backgroundColor: const Color(0xD9D9D9).withOpacity(1),
                      elevation: 0,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        
                        
                      ),
                    ),              
                    ),
                    
                    
                  ),
                ),
                Positioned(
                top: -ScreenHeight*0.12,
                left: (ScreenWidth*0.9-135)/2,

                child: Container(
                  width: 135,
                  child: Text(
                    "LOGIN",
                     style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                                      ),
                                ),
                ),
              ),
              Positioned(
                left: (ScreenWidth*0.9-ScreenWidth*0.75)/2,
                top:  (ScreenHeight*0.4+100) ,
                child: Container(
                  width: ScreenWidth*0.75,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),                
                ),
              ),
              Positioned(
                left: (ScreenWidth*0.9-175)/2,
                top:  (ScreenHeight*0.4+180) ,
                child: Container(
                  width: 115,
                  child: Text(
                    "NOT A MEMBER ?"
                  ),
                ),
              ),
              Positioned(
                left: (ScreenWidth*0.9+60)/2,
                top:(ScreenHeight*0.4+180) ,
                child: Container(
                  width: 60,
                    child:InkWell(
                      onTap: (){},  
                      child: 
                      Text(
                        ' SIGN UP',
                      style: TextStyle(
                        color: Colors.green,
                        fontStyle: FontStyle.italic
                        ),
                      textAlign:TextAlign.right,
                      )
                      ),
                    
                  ),
              )
                
                ],
                
                            
              ),
              
              
              
                            
              
            ],
          ),
                    
        ),
        
      ),
    );
  }
}