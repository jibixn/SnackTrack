import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snack_track/cart.dart';
import 'package:snack_track/db/models/cart_model.dart';
import 'package:snack_track/SlidingButton.dart';
import 'dash.dart';
import 'login.dart';
import 'screen_main_page.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 if (!Hive.isAdapterRegistered(cartModelAdapter().typeId)){
  Hive.registerAdapter(cartModelAdapter());
 }
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
        '/cart':(context)=>CartPage(),
        '/login':(context)=>LoginScreen(),
        '/test':(context)=>SlidingButtonExample(),
      }
    );
  
  }
  
}