import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_viraj_new/homepage.dart';
import 'package:login_register_viraj_new/signup.dart';
import 'package:login_register_viraj_new/splashscreen.dart';

import 'Paymentgateway.dart';

void main() {
  runApp(MaterialApp(
    home: splashscreenn(),
    builder: EasyLoading.init(),
  ));
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool passwordstatuss = true;

  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    double theight = MediaQuery.of(context).size.height;
    double statusbar = MediaQuery.of(context).padding.top;
    double navbar = MediaQuery.of(context).padding.bottom;
    double appbar = kToolbarHeight;

    double bheight = theight - statusbar - navbar;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          height: bheight,
          width: twidth,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Image(image: AssetImage("images/logo.png")),
                height: 400,
                width: twidth,
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                height: 100,
                width: twidth,
                child: TextField(
                    onChanged: (value) {
                      if (email.text != "") {
                        setState(() {
                          emailstatus = true;
                        });
                      }
                    },
                    controller: email,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff7c553b), width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7c553b))),
                        errorText: emailstatus ? null : "plz Enter Email",
                        hintText: "Enter Email or Mobile Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                height: 100,
                width: twidth,
                child: TextField(
                    obscureText: passwordstatuss,
                    onChanged: (value) {
                      if (password.text != "") {
                        setState(() {
                          passwordstatus = true;
                        });
                      }
                    },
                    controller: password,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        suffix: InkWell(
                            onTap: () {
                              setState(() {
                                if (passwordstatuss) {
                                  passwordstatuss = false;
                                } else {
                                  passwordstatuss = true;
                                }
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.all(3),
                                child: Icon(
                                  passwordstatuss
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xff7c553b),
                                ))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff7c553b), width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff7c553b))),
                        errorText: passwordstatus ? null : "plz Enter Password",
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                    child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (email.text == "") {
                          setState(() {
                            emailstatus = false;
                          });
                        }

                        if (password.text == "") {
                          setState(() {
                            passwordstatus = false;
                          });
                        }

                        if (passwordstatus == true && emailstatus == true) {
                          EasyLoading.show(status: 'Logging in...');

                          String emaill = email.text;
                          String passwordd = password.text;

                          Map map = {"username": emaill, "password": passwordd};

                          var url = Uri.parse(
                              'https://virraj.000webhostapp.com/API/login.php');
                          var response = await http.post(url, body: map);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          var lll = jsonDecode(response.body);

                          login llll = login.fromJson(lll);

                          if (llll.connection == 1) {
                            if (llll.result == 1) {
                              String? id = llll.userdata!.id;
                              String? name = llll.userdata!.name;
                              String? emaiil = llll.userdata!.email;
                              String? numberr = llll.userdata!.number;
                              String? passsword = llll.userdata!.password;
                              String? imagepath = llll.userdata!.imagepath;

                              splashscreenn.pref!.setBool("login", true);

                              splashscreenn.pref!.setString("id", id!);
                              splashscreenn.pref!.setString("name", name!);
                              splashscreenn.pref!.setString("emaiil", emaiil!);
                              splashscreenn.pref!
                                  .setString("numberr", numberr!);
                              splashscreenn.pref!
                                  .setString("passsword", passsword!);
                              splashscreenn.pref!
                                  .setString("imagepath", imagepath!);

                              // Fluttertoast.showToast(
                              //     msg: "${llll.userdata!.name}",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0);
                              EasyLoading.dismiss();

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return homepage();
                                },
                              ));

                              print("we did it(login)");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Username or Password incorrect",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color(0xff7c553b),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              EasyLoading.dismiss();
                            }
                          }
                        }
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                        decoration: BoxDecoration(
                            color: Color(0xff7c553b),
                            borderRadius: BorderRadius.circular(30)),
                        height: 60,
                        width: twidth * 0.5,
                      ),
                    ),
                    // Container(
                    //     margin: EdgeInsets.only(top: 5),
                    //     height: 20,
                    //     child: RichText(
                    //         text: TextSpan(
                    //       children: [
                    //         TextSpan(
                    //             text: "Don't Have an Account?",
                    //             style: TextStyle(color: Colors.black)),
                    //         TextSpan(
                    //             text: "Sign Up",
                    //             style: TextStyle(
                    //                 color: Colors.blueAccent,
                    //                 decoration: TextDecoration.underline)),
                    //
                    //       ],
                    //     )))
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have an Account?",
                                style: TextStyle(fontSize: 15)),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return signuppage();
                                  },
                                ));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff7c553b)),
                              ),
                            )
                          ]),
                    )
                  ],
                )),
                height: 140,
                width: twidth,
              ),
            ],
          ),
        )),
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool emailstatus = true;
  bool passwordstatus = true;
}

class login {
  int? connection;
  int? result;
  Userdata? userdata;

  login({this.connection, this.result, this.userdata});

  login.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? number;
  String? email;
  String? password;
  String? imagepath;

  Userdata(
      {this.id,
      this.name,
      this.number,
      this.email,
      this.password,
      this.imagepath});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    password = json['password'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imagepath'] = this.imagepath;
    return data;
  }
}
