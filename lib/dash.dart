import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MainDash extends StatelessWidget {
  const MainDash({super.key});

  @override
  Widget build(BuildContext context) {
    double ScreenWidth =MediaQuery.of(context).size.width;
    String name ='';
    return  Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Welcome Back,'+name,
          style: TextStyle(
            fontWeight: FontWeight.w700
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(            
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.black12
                    ),
                    
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}