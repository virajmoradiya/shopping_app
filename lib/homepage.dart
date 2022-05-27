import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_viraj_new/main.dart';
import 'package:login_register_viraj_new/splashscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'viewproductpage.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? id;
  String? name;
  String? email;
  String? number;
  String? password;
  String? imagepath;
  bool imageget = false;
  int cnt = 1;

  List<Widget> lisst = [addproduct(), viewproduct()];
  String folderpath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = splashscreenn.pref!.getString("id");
    name = splashscreenn.pref!.getString("name");
    email = splashscreenn.pref!.getString("emaiil");
    number = splashscreenn.pref!.getString("numberr");
    password = splashscreenn.pref!.getString("passsword");
    imagepath = splashscreenn.pref!.getString("imagepath");

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        imageget = true;
      });
    });
    forpermission();
  }

  forpermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();

      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
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
        drawer: Container(
          color: Colors.white,
          width: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(35),
                child: CircleAvatar(
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://virraj.000webhostapp.com/API/${imagepath}"),
                    radius: 60,
                    backgroundImage: AssetImage("images/profilee.gif"),
                  ),
                  radius: 60,
                  backgroundColor: Colors.white,
                ),
                height: 200,
              ),
              Divider(
                color: Color(0xff7c553b),
                thickness: 1,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      cnt = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(margin: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Center(
                                    child: Text(
                              "Add Product",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Color(0xff7c553b)),
                            ))),
                            Container(
                              child: Icon(Icons.add_box,
                                  color: Color(0xff7c553b), size: 30),
                            )
                          ]),
                      height: 40)),
              Divider(
                color: Color(0xff7c553b),
                thickness: 1,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      cnt = 1;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(margin: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Center(
                                    child: Text(
                              "View Product",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: Color(0xff7c553b)),
                            ))),
                            Container(
                              child: Icon(Icons.home_filled,
                                  color: Color(0xff7c553b), size: 30),
                            )
                          ]),
                      height: 40)),
              Divider(
                color: Color(0xff7c553b),
                thickness: 1,
              ),
              InkWell(
                  onTap: () {
                    splashscreenn.pref!.setBool("login", false);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return loginpage();
                      },
                    ));
                  },
                  child: Container(
                    child: Center(
                        child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )),
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color(0xff7c553b),
                        borderRadius: BorderRadius.circular(15)),
                  )),
            ],
          ),
        ),
        appBar: AppBar(
            backgroundColor: Color(0xff7c553b),
            title: Text(
              "Home Page",
              style: TextStyle(fontSize: 25),
            ),
            actions: [
              InkWell(
                onTap: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      animType: AnimType.SCALE,
                      body: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(35),
                              child: CircleAvatar(
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                      "https://virraj.000webhostapp.com/API/${imagepath}"),
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage("images/profilee.gif"),
                                ),
                                radius: 60,
                                backgroundColor: Colors.white,
                              ),
                              height: 200,
                              width: double.infinity,
                            ),
                            Divider(
                              color: Color(0xff7c553b),
                              thickness: 1,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    cnt = 0;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Center(
                                                  child: Text(
                                            "Add Product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                                color: Color(0xff7c553b)),
                                          ))),
                                          Container(
                                            child: Icon(Icons.add_box,
                                                color: Color(0xff7c553b),
                                                size: 30),
                                          )
                                        ]),
                                    height: 40,
                                    width: double.infinity)),
                            Divider(
                              color: Color(0xff7c553b),
                              thickness: 1,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    cnt = 1;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Center(
                                                  child: Text(
                                            "View Product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                                color: Color(0xff7c553b)),
                                          ))),
                                          Container(
                                            child: Icon(Icons.home_filled,
                                                color: Color(0xff7c553b),
                                                size: 30),
                                          )
                                        ]),
                                    height: 40,
                                    width: double.infinity)),
                            Divider(
                              color: Color(0xff7c553b),
                              thickness: 1,
                            ),
                            InkWell(
                                onTap: () {
                                  splashscreenn.pref!.setBool("login", false);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return loginpage();
                                    },
                                  ));
                                },
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )),
                                  height: 50,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: Color(0xff7c553b),
                                      borderRadius: BorderRadius.circular(15)),
                                )),
                          ],
                        ),
                      ))
                    ..show();
                },
                child: Container(
                  margin: EdgeInsets.all(7),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/profilee.gif"),
                        foregroundImage: NetworkImage(
                            "https://virraj.000webhostapp.com/API/${imagepath}"),
                      )),
                  height: double.infinity,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://virraj.000webhostapp.com/API/${imagepath}"))),
                ),
              )
            ]),
        body: lisst[cnt],
        // drawer: Drawer(
        //     child: Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.all(35),
        //       child: CircleAvatar(
        //         child: CircleAvatar(
        //           foregroundImage: NetworkImage(
        //               "https://virraj.000webhostapp.com/API/${imagepath}"),
        //           radius: 60,
        //           backgroundImage: AssetImage("images/profilee.gif"),
        //         ),
        //         radius: 60,
        //         backgroundColor: Colors.white,
        //       ),
        //       height: 200,
        //       width: double.infinity,
        //       color: Color(0xff7c553b),
        //     )
        //   ],
        // )),
      ),
    );
  }
}

class addproduct extends StatefulWidget {
  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    double theight = MediaQuery.of(context).size.height;
    double statusbar = MediaQuery.of(context).padding.top;
    double navbar = MediaQuery.of(context).padding.bottom;
    double appbar = kToolbarHeight;

    double bheight = theight - statusbar - navbar - appbar;
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
        child: Column(children: [
          Container(
            width: twidth,
            height: imagelist.length < 3 ? 150 : 260,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: imagelist.length + 1,
                itemBuilder: (context, index) {
                  if (index == imagelist.length) {
                    print("wow");

                    return InkWell(
                      onTap: () async {
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          String imagepath = image!.path;
                          imagelist.add(imagepath);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/plus.gif")),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff7c553b))),
                      ),
                    );
                  }
                  if (index < imagelist.length) {
                    print("wow22");
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File("${imagelist[index]}"))),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff7c553b))),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/plus.gif")),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff7c553b))),
                  );
                }),
          ),
          Center(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  width: twidth * 0.495,
                  height: 95,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: twidth * 0.55,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            pricestatus = true;
                          });
                        },
                        controller: price,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff7c553b)),
                        decoration: InputDecoration(
                            errorText:
                                pricestatus ? null : "Please Enter Price",
                            labelText: "Product Price",
                            labelStyle: TextStyle(color: Color(0xff7c553b)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff7c553b))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff7c553b))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff7c553b), width: 1.5)))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  width: twidth * 0.495,
                  height: 95,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: twidth * 0.55,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            comparestatus = true;
                          });
                        },
                        controller: compareprice,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff7c553b)),
                        decoration: InputDecoration(
                            errorText:
                                comparestatus ? null : "${comppareerrortext}",
                            labelText: "Compare Price",
                            labelStyle: TextStyle(color: Color(0xff7c553b)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff7c553b))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff7c553b))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff7c553b), width: 1.5)))),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            width: twidth,
            height: 75,
            child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    namestatus = true;
                  });
                },
                controller: name,
                style: TextStyle(fontSize: 20, color: Color(0xff7c553b)),
                decoration: InputDecoration(
                    errorText: namestatus ? null : "Please Enter Product Name",
                    labelText: "Product Name",
                    labelStyle: TextStyle(color: Color(0xff7c553b)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff7c553b))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff7c553b), width: 1.5)))),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            width: twidth,
            height: 190,
            child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    descstatus = true;
                  });
                },
                controller: description,
                maxLines: 6,
                style: TextStyle(fontSize: 20, color: Color(0xff7c553b)),
                decoration: InputDecoration(
                    errorText: descstatus ? null : "Please Enter Product Desc",
                    labelText: "Product Description",
                    labelStyle: TextStyle(color: Color(0xff7c553b)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff7c553b))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff7c553b), width: 1.5)))),
          ),
          InkWell(
            onTap: () async {
              // int comparee = int.parse(compareprice.text.toString());
              // int pricee = int.parse(compareprice.text.toString());

              if (price.text.isEmpty) {
                setState(() {
                  pricestatus = false;
                });
              }
              if (name.text.isEmpty) {
                setState(() {
                  namestatus = false;
                });
              }
              if (description.text.isEmpty) {
                setState(() {
                  descstatus = false;
                });
              }
              if (compareprice.text.isEmpty) {
                setState(() {
                  comparestatus = false;
                });
              } else {
                if (int.parse(compareprice.text.toString()) <
                    int.parse(price.text.toString())) {
                  setState(() {
                    comparestatus = false;
                    comppareerrortext =
                        "Compare Price Must be \nGreater then Actual Price";
                  });
                }
              }

              if (imagelist.length == 0) {
                Fluttertoast.showToast(
                    msg: "Select Atleat One Image",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xff7c553b),
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              if (price.text.isNotEmpty &&
                  name.text.isNotEmpty &&
                  description.text.isNotEmpty &&
                  compareprice.text.isNotEmpty &&
                  comparestatus == true &&
                  imagelist.length > 0) {
                EasyLoading.show(status: 'adding product...');

                String pricee = price.text;
                String namee = name.text;
                String desc = description.text;
                String compare = compareprice.text;
                String? userid = splashscreenn.pref!.getString("id");
                for (int i = 0; i < imagelist.length; i++) {
                  List<int> imagee = File(imagelist[i]).readAsBytesSync();
                  image[i] = base64Encode(imagee);
                }
                image0 = image[0];
                image1 = image[1];
                image2 = image[2];
                image3 = image[3];
                image4 = image[4];
                image5 = image[5];

                Map map = {
                  "userid": userid,
                  "pricee": pricee,
                  "name": namee,
                  "desc": desc,
                  "image0": image0,
                  "image1": image1,
                  "image2": image2,
                  "image3": image3,
                  "image4": image4,
                  "image5": image5,
                  "length": imagelist.length.toString(),
                  "compareprice": compare
                };

                var url = Uri.parse(
                    'https://virraj.000webhostapp.com/API/add_product.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                print("kkkkkk${response.body}");
                var adding = json.decode(response.body.toString());
                print("etsrtrd${adding}");

                productadd addder = productadd.fromJson(adding);

                print("conn===${addder.connection}");

                EasyLoading.dismiss();

                if (addder.connection == 1) {
                  print("good");
                  if (addder.result == 1) {
                    print("gooddd");
                    Fluttertoast.showToast(
                        msg: "Product Added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff7c553b),
                        textColor: Colors.white,
                        fontSize: 16.0);

                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return homepage();
                      },));
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Try Again Later",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff7c553b),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Server Timeout",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xff7c553b),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            },
            child: Container(
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(fontSize: 40, color: Colors.white),
              )),
              height: 70,
              width: twidth * 0.5,
              decoration: BoxDecoration(
                  color: Color(0xff7c553b),
                  borderRadius: BorderRadius.circular(35)),
            ),
          )
        ]),
      ))),
    );
  }

  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController compareprice = TextEditingController();
  ImagePicker picker = ImagePicker();
  List<String> imagelist = [];
  List<String> image = List.filled(6, "");
  String image0 = "";
  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";
  String image5 = "";
  bool pricestatus = true;
  bool namestatus = true;
  bool descstatus = true;
  bool comparestatus = true;
  String comppareerrortext = "Please Enter Compare Text";
}

class productadd {
  int? connection;
  int? result;

  productadd({this.connection, this.result});

  productadd.fromJson(Map<String, dynamic> json) {
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

class viewproduct extends StatefulWidget {
  const viewproduct({Key? key}) : super(key: key);

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {
  // int listlength = 0;
  // List? productid;
  // List? productprice;
  // List? productname;
  // List? productdesc;
  // List? productimg0;
  // List? productimg1;
  // List? productimg2;
  // List? productimg3;
  // List? productimg4;
  // List? productimg5;

  int listlength = 0;
  List productid = [];
  List productprice = [];
  List productcompareprice = [];
  List productname = [];
  List productdesc = [];
  List productimg0 = [];
  List productimg1 = [];
  List productimg2 = [];
  List productimg3 = [];
  List productimg4 = [];
  List productimg5 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getproductdetails();
  }

  getproductdetails() async {
    String userid = splashscreenn.pref!.getString("id") ?? "";
    Map map = {"userid": userid};

    var url = Uri.parse('https://virraj.000webhostapp.com/API/viewproduct.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mapp = jsonDecode(response.body);

    productdetails ppp = productdetails.fromJson(mapp);

    setState(() {
      listlength = ppp.productdata!.length.toInt();
    });

    print("listlength = ${listlength}");

    print("ppp.productdata![i].image0; ${ppp.productdata![0].image0}");

    for (int i = 0; i < listlength; i++) {
      // productid![i] = ppp.productdata![i].id;
      // productprice![i] = ppp.productdata![i].price;
      // productname![i] = ppp.productdata![i].productName;
      // productdesc![i] = ppp.productdata![i].productDesc;
      // productimg0![i] = ppp.productdata![i].image0;
      // productimg1![i] = ppp.productdata![i].image1;
      // productimg2![i] = ppp.productdata![i].image2;
      // productimg3![i] = ppp.productdata![i].image3;
      // productimg4![i] = ppp.productdata![i].image4;
      // productimg5![i] = ppp.productdata![i].image5;
      productid.add(ppp.productdata![i].id);
      productprice.add(ppp.productdata![i].price);
      productcompareprice.add(ppp.productdata![i].comparePrice);
      productname.add(ppp.productdata![i].productName);
      productdesc.add(ppp.productdata![i].productDesc);
      productimg0.add(ppp.productdata![i].image0);
      productimg1.add(ppp.productdata![i].image1);
      productimg2.add(ppp.productdata![i].image2);
      productimg3.add(ppp.productdata![i].image3);
      productimg4.add(ppp.productdata![i].image4);
      productimg5.add(ppp.productdata![i].image5);
    }
    print(productimg0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: ListView.builder(
                  itemCount: listlength,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return viewpage(
                              productid[index],
                              productprice[index],
                              productcompareprice[index],
                              productname[index],
                              productdesc[index],
                              productimg0[index],
                              productimg1[index],
                              productimg2[index],
                              productimg3[index],
                              productimg4[index],
                              productimg5[index],
                            );
                          },
                        ));
                      },
                      child: Card(
                        child: Row(children: [
                          Hero(
                            tag: "image",
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 80,
                              height:80,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://virraj.000webhostapp.com/API/${productimg0[index]}"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 30,
                                child: Text("${productname[index]}",
                                    style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        fontSize: 25)),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "₹${productcompareprice[index]}/-",
                                        style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0x80000000)),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "₹${productprice[index]}/-",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${100 * (int.parse(productcompareprice[index]) - int.parse(productprice[index])) ~/ int.parse(productcompareprice[index])}% off",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                width: 150,
                                height: 30,
                              ),
                            ],
                          )
                        ]),
                        margin: EdgeInsets.all(10),elevation: 5,
                      ),
                    );
                  }))),
    );
  }
}

class productdetails {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  productdetails({this.connection, this.result, this.productdata});

  productdetails.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? userId;
  String? price;
  String? productName;
  String? productDesc;
  String? comparePrice;
  String? length;
  String? image0;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;

  Productdata(
      {this.id,
      this.userId,
      this.price,
      this.productName,
      this.productDesc,
      this.comparePrice,
      this.length,
      this.image0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    price = json['price'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    comparePrice = json['compare_price'];
    length = json['length'];
    image0 = json['image0'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    image5 = json['image5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['product_name'] = this.productName;
    data['product_desc'] = this.productDesc;
    data['compare_price'] = this.comparePrice;
    data['length'] = this.length;
    data['image0'] = this.image0;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['image5'] = this.image5;
    return data;
  }
}
