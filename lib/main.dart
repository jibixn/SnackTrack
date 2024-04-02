import 'package:flutter/material.dart';
import 'dash.dart';
import 'login.dart';
import 'screen_main_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(     
      theme: ThemeData(
        primaryColor: Colors.white,        
      ),
      home: LoginScreen(),
      routes: {
        '/home':(context)=>ScreenMainPage(),
        '/login':(context)=>LoginScreen(),
      }
    );
  
  }
  
}