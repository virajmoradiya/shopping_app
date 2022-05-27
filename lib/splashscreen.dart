import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login_register_viraj_new/homepage.dart';
import 'package:login_register_viraj_new/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreenn extends StatefulWidget {
  static SharedPreferences? pref;

  @override
  State<splashscreenn> createState() => _splashscreennState();
}

class _splashscreennState extends State<splashscreenn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshare();
  }


  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    double theight = MediaQuery.of(context).size.height;
    double statusbar = MediaQuery.of(context).padding.top;
    double navbar = MediaQuery.of(context).padding.bottom;
    double appbar = kToolbarHeight;

    double bheight = theight - statusbar - navbar;

    return SafeArea(
      child: Scaffold(
        // body: Center(child: Container(child: Icon(Icons.email, size: 100))),
        body: Container(width: twidth,
          height: bheight,color: Colors.white,
          child: Center(
              child: Container(
            child: Image(image: AssetImage("images/splash.gif")),
            width: 100,
            height: 100,
                color: Colors.white,
          )),
        ),
      ),
    );
  }

  Future<void> getshare() async {
    splashscreenn.pref = await SharedPreferences.getInstance();

    setState(() {
      status = splashscreenn.pref!.getBool("login") ?? false;
    });

    if (status) {
      Future.delayed(Duration(seconds: 4)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return homepage();
          },
        ));
      });
    } else {
      Future.delayed(Duration(seconds: 4)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return loginpage();
          },
        ));
      });
    }
  }
  bool status = false;
  List map = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
}
