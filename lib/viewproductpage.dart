import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_viraj_new/editpage.dart';
import 'package:login_register_viraj_new/homepage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class viewpage extends StatefulWidget {
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

  viewpage(
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
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List img = List.filled(6, "");
  List image = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    img[0] = widget.productimg0;
    img[1] = widget.productimg1;
    img[2] = widget.productimg2;
    img[3] = widget.productimg3;
    img[4] = widget.productimg4;
    img[5] = widget.productimg5;
    for (int i = 0; i < 6; i++) {
      if (img[i] != "") {
        image.add(img[i]);
      }
    }

    @override
    void dispose() {
      super.dispose();
      razorpay.clear();
    }

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

  }
  late Razorpay razorpay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        child: Column(children: [
          Container(
            height: 65,
            child: Row(children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () async {
                  print("working");
                  EasyLoading.show(status: 'Deleting product...');
                  var url = Uri.parse(
                      'https://virraj.000webhostapp.com/API/delete_product.php');
                  var response = await http
                      .post(url, body: {"productid": widget.productid});
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Product deleted Successfully"),
                    backgroundColor: Colors.black,
                  ));
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return viewproduct();
                      },
                    ));
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return editpage(
                          widget.productid,
                          widget.productprice,
                          widget.productcompareprice,
                          widget.productname,
                          widget.productdesc,
                          widget.productimg0,
                          widget.productimg1,
                          widget.productimg2,
                          widget.productimg3,
                          widget.productimg4,
                          widget.productimg5);
                    },
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ]),
          ),
          Hero(
            tag: "image",
            child: Container(
              child: CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://virraj.000webhostapp.com/API/${image[index]}"),
                              fit: BoxFit.fill)),
                    );
                  },
                  itemCount: image.length,
                  options: CarouselOptions()),
              width: double.infinity,
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(10),
                child: Text(
                  "${widget.productname}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      "₹${widget.productcompareprice}/-",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0x80000000)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      "₹${widget.productprice}/-",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      "${100 * (int.parse(widget.productcompareprice!) - int.parse(widget.productprice!)) ~/ int.parse(widget.productcompareprice!)}% off",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:-",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.productdesc}",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ]),
              )
            ]),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white),
          ),
          Spacer(),
          InkWell(
              onTap: () {
                openCheckout();
              },
              child: Container(
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
                height: 80,
                decoration: BoxDecoration(color: Colors.blue),
              ))
        ]),
      )),
    );
  }
  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ahVV6v3FyvtjJ5',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9898419400', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
     Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
     Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}

