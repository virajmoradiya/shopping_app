import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_viraj_new/main.dart';

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      opacity: 80,
                      image: AssetImage("images/register banner.png"),
                      fit: BoxFit.fill)),
              child: Center(
                  child: InkWell(
                onTap: () {
                  AwesomeDialog(
                    width: twidth,
                    body: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    imagepath = image!.path;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("images/gallery.png"),
                                          fit: BoxFit.fill)),
                                  width: twidth * 0.25,
                                  height: 100,
                                ),
                              ),
                              Text(
                                "Select From \n   Gallery",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    imagepath = image!.path;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("images/camera.png"))),
                                  width: twidth * 0.25,
                                  height: 100,
                                ),
                              ),
                              Text(
                                "Click Fresh\n   Picture",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )
                        ])),
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.NO_HEADER,
                  )..show();
                },
                child: imagepath == ""
                    ? Container(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundImage: AssetImage("images/profilee.gif"),
                        ))
                    : Container(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(imagepath)),
                          ),
                        )),
              )),
              height: 200,
              width: twidth,
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 100,
              width: twidth,
              child: TextField(
                  onChanged: (value) {
                    if (name.text != "") {
                      setState(() {
                        namestatus = true;
                      });
                    }
                  },
                  controller: name,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff7c553b), width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff7c553b))),
                      errorText: namestatus ? null : "plz Enter Name",
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 100,
              width: twidth,
              child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    if (mobile.text != "") {
                      setState(() {
                        mobilestatus = true;
                      });
                    }
                  },
                  controller: mobile,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff7c553b), width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff7c553b))),
                      errorText:
                          mobilestatus ? null : "plz Enter Mobile Number",
                      hintText: "Enter Mobile Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
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
                      hintText: "Enter Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 120,
              width: twidth,
              child: TextField(
                  obscureText: true,
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
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: FlutterPasswordStrength(
                    password: password.text,
                    strengthCallback: (strength) {
                      print(strength.toString());
                    })),
            InkWell(
              onTap: () async {
                if (name.text == "") {
                  setState(() {
                    namestatus = false;
                  });
                }
                if (mobile.text == "") {
                  setState(() {
                    mobilestatus = false;
                  });
                }

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

                if (email.text.contains("@") == true &&
                    email.text.contains(".com") == true) {
                  setState(() {
                    emailstatus = true;
                  });
                } else
                  (setState(() {
                    emailstatus = false;
                  }));

                if (namestatus == true &&
                    mobilestatus == true &&
                    emailstatus == true &&
                    passwordstatus == true) {

                  EasyLoading.show(status: 'loading...');

                  String namee = name.text;
                  String emaill = email.text;
                  String mobilee = mobile.text;
                  String passwordd = password.text;

                  List<int> image = File(imagepath).readAsBytesSync();
                  String imagedata = base64Encode(image);
                  print(imagedata);

                  Map map = {
                    "name": namee,
                    "email": emaill,
                    "mobile": mobilee,
                    "password": passwordd,
                    "imagedata": imagedata
                  };

                  var url = Uri.parse(
                      'https://virraj.000webhostapp.com/API/register.php');
                  var response = await http.post(url, body: map);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  var addd = jsonDecode(response.body);

                  register rrr = register.fromJson(addd);

                  if (rrr.connection == 1) {
                    if (rrr.result == 1) {
                      Fluttertoast.showToast(
                          msg: "Registration Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff7c553b),
                          textColor: Colors.white,
                          fontSize: 16.0);

                      EasyLoading.dismiss();
                      Future.delayed(Duration(seconds: 2),(){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return loginpage();
                          },
                        ));
                      });
                    } else if (rrr.result == 2) {
                      Fluttertoast.showToast(
                          msg: "change email or mobile number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff7c553b),
                          textColor: Colors.white,
                          fontSize: 16.0);

                      EasyLoading.dismiss();
                    } else {
                      Fluttertoast.showToast(
                          msg: "developer error",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff7c553b),
                          textColor: Colors.white,
                          fontSize: 16.0);

                      EasyLoading.dismiss();
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "server not connected",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff7c553b),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }

                }
                // var emailll = email.text;
                // bool emailValid = RegExp(
                //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(emailll);
                // print(emailValid);
              },
              child: Container(
                child: Center(
                    child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
                decoration: BoxDecoration(
                    color: Color(0xff7c553b),
                    borderRadius: BorderRadius.circular(30)),
                height: 60,
                width: twidth * 0.5,
              ),
            ),
          ],
        )),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  bool namestatus = true;
  TextEditingController mobile = TextEditingController();
  bool mobilestatus = true;
  TextEditingController email = TextEditingController();
  bool emailstatus = true;
  TextEditingController password = TextEditingController();
  bool passwordstatus = true;
  ImagePicker picker = ImagePicker();
  String imagepath = "";
}

class register {
  int? connection;
  int? result;

  register({this.connection, this.result});

  register.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
