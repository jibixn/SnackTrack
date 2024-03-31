import 'package:flutter/material.dart';

class Drawer_Menu extends StatelessWidget {
  const Drawer_Menu({super.key});

  @override
  Widget build(BuildContext context) {
    double ScreenWidth =MediaQuery.of(context).size.width;
    return Drawer(
      width: ScreenWidth*0.65,
        child: ListView(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "MENU",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w800,
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Container(
                          height: 2,
                          width: ScreenWidth*0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                    Container(
                      width: 75,
                      height: 10,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: Padding(
               padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                    Container(
                      width: 75,
                      height: 10,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                    Container(
                      width: 75,
                      height: 10,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                    Container(
                      width: 75,
                      height: 10,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                    Container(
                      width: 75,
                      height: 10,
                      decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                    ),
                  ],
                ),
              ),
            ),
            
            ListTile(              
              title: Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom: 25.0),
                child: Center(
                  child: Container(
                    width: 175,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(121, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/login');                  
                        },
                        child: Text(
                           "Log Out",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                        ),                       
                      ),
                    ),
                  ),
                ),
              ),              
            ),
          ],
        ),
    );
  }
}