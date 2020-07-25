import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'homescreen.dart';
import 'login.dart';





class SplashScreen extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
with SingleTickerProviderStateMixin {
 
 startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreenWidget()));
  }
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    startTime();
  }
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return 
    Scaffold(
      body: 
      Container(
      margin: EdgeInsets.only(top: height*0.4,),
      child:
        Column(
          children: <Widget>[
            Container(
              //color: Colors.blue,
              height: height*0.2,
              child: 
              SlideTransition(position: _offsetAnimation,
              child: SvgPicture.asset("assets/images/time.svg"),
              )),
              
             // child: Image.asset('assets/images/file.png'),
            
            SizedBox(height: height*0.05,),
            Container(
              //color: Colors.white,
              child: 
               Center(
                 child: Text("Welcome to Exampedia India"),
                     )
            ),
          ],
        ),
        )
        
        
    
    );

  }
}