import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_viraj_new/homepage.dart';
import 'package:http/http.dart' as http;

class editpage extends StatefulWidget {
  String? productid;
  String? productprice;
  String? productcompareprice;
  String? productname;
  String? productdesc;
  String? productimg0;
  String? productimg1;
  String? productimg2;
  String? productimg3;
  String? productimg4;
  String? productimg5;

  editpage(
      this.productid,
      this.productprice,
      this.productcompareprice,
      this.productname,
      this.productdesc,
      this.productimg0,
      this.productimg1,
      this.productimg2,
      this.productimg3,
      this.productimg4,
      this.productimg5);

  @override
  State<editpage> createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  TextEditingController price = TextEditingController();
  TextEditingController compareprice = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  ImagePicker picker = ImagePicker();
  List imagelist = [];
  List image = List.filled(6, "");
  String image0 = "";
  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";
  String image5 = "";
  bool pricestatus = true;
  bool comparestatus = true;
  bool namestatus = true;
  bool descstatus = true;
  String comppareerrortext = "Please Enter Compare Text";
  List kk = List.filled(6, "");
  int stringlength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      price.text = widget.productprice!;
      compareprice.text = widget.productcompareprice!;
      name.text = widget.productname!;
      description.text = widget.productdesc!;
      kk[0] = widget.productimg0;
      kk[1] = widget.productimg1;
      kk[2] = widget.productimg2;
      kk[3] = widget.productimg3;
      kk[4] = widget.productimg4;
      kk[5] = widget.productimg5;
    });

    for (int i = 0; i < kk.length; i++) {
      if (kk[i] == "") {
        print("null it is");
      } else {
        imagelist.add(kk[i]);
        print("not null");
      }
    }
    stringlength = imagelist.length;
    print("string length 1 = $stringlength");
  }

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
                    if (index < stringlength) {
                      return Container(
                        height: 130,
                        width: 130,
                        child: Stack(children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://virraj.000webhostapp.com/API/${imagelist[index]}")),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff7c553b))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    imagelist.removeAt(index);
                                    stringlength = stringlength - 1;
                                  });
                                },
                                child: Container(
                                  child: Icon(Icons.close, color: Colors.white),
                                  margin: EdgeInsets.all(10),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Color(0xff7c553b),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      );
                    } else {
                      return Container(
                        height: 130,
                        width: 130,
                        child: Stack(children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        FileImage(File("${imagelist[index]}"))),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff7c553b))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    print("stringlength 2 = $stringlength");
                                    imagelist.removeAt(index);
                                    stringlength = stringlength - 1;
                                  });
                                },
                                child: Container(
                                  child: Icon(Icons.close, color: Colors.white),
                                  margin: EdgeInsets.all(10),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Color(0xff7c553b),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      );
                    }
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
                EasyLoading.show(status: 'updating product...');
                print("11");
                print("====================${imagelist}");
                for (int i = 0; i < imagelist.length; i++) {
                  if (stringlength <= i) {
                    print("done 1");
                    List<int> imagee = File(imagelist[i]).readAsBytesSync();
                    image[i] = base64Encode(imagee);
                  }
                  else{
                    print("done 2");
                    image[i]=imagelist[i];
                    print(image);
                  }
                }

                print("111");
                image0 = image[0];
                image1 = image[1];
                image2 = image[2];
                image3 = image[3];
                image4 = image[4];
                image5 = image[5];

                Map map = {
                  "id": widget.productid,
                  "price": price.text,
                  "compareprice": compareprice.text,
                  "name": name.text,
                  "desc": description.text,
                  "image0": image0,
                  "image1": image1,
                  "image2": image2,
                  "image3": image3,
                  "image4": image4,
                  "image5": image5,
                  "length": stringlength.toString()
                };
                print("map done");
                var url = Uri.parse(
                    'https://virraj.000webhostapp.com/API/update_product.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                print("API done");

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
                        msg: "Product updated Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff7c553b),
                        textColor: Colors.white,
                        fontSize: 16.0);
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
                "Update Product",
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
              height: 70,
              width: twidth * 0.7,
              decoration: BoxDecoration(
                  color: Color(0xff7c553b),
                  borderRadius: BorderRadius.circular(35)),
            ),
          )
        ]),
      ))),
    );
  }
}
