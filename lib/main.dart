import 'package:flutter/material.dart';
import 'package:snack_track/dash.dart';
import 'package:snack_track/login.dart';

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
        '/home':(context)=>MainDash(),
        '/login':(context)=>LoginScreen(),
      }
    );
  
  }
  
}