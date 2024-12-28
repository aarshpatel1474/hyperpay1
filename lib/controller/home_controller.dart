import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';

class HomeController extends GetxController {


  RxBool isLoading = false.obs;




  RxList<String> imageList = <String>[
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ].obs;

  RxList<Map<String,dynamic>> apartmentDetailsList = <Map<String,dynamic>>[
    {
      'icon' : "assets/icon/ic_bedroom.png",
      'title':"Bedroom",
      'sub_title':"2 bedrooms"
    },
    {
      'icon' : "assets/icon/ic_bathroom.png",
      'title':"Bathroom",
      'sub_title':"2 bathrooms"
    },
    {
      'icon' : "assets/icon/ic_size.png",
      'title':"Size",
      'sub_title':"200 Sqft"
    },
    {
      'icon' : "assets/icon/ic_parking.png",
      'title':"Shaded parking",
      'sub_title':"No"
    },
    {
      'icon' : "assets/icon/ic_multiple_parking.png",
      'title':"Multiple car parking",
      'sub_title':"No"
    },
    {
      'icon' : "assets/icon/ic_support.png",
      'title':"Internet support",
      'sub_title':"Yes"
    },
    {
      'icon' : "assets/icon/ic_ac.png",
      'title':"AC installed",
      'sub_title':"Yes"
    },
    {
      'icon' : "assets/icon/ic_swiming_pool.png",
      'title':"Swimming pool",
      'sub_title':"Yes"
    },
  ].obs;



  FlutterHyperPay flutterHyperPay = FlutterHyperPay(
  shopperResultUrl: 'https://test.com/paymentResult', // For testing only
  paymentMode: PaymentMode.test,
  lang: 'en',
  );


  Future <void> getCheckOut() async {
    try{
      isLoading.value = true;
      final url =
      Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        payRequestNowReadyUI(
          checkoutId: json.decode(response.body)['id'],
          brandsName: ["VISA", "MASTER"],
        );
      } else {
        log(response.body.toString(), name: "STATUS CODE ERROR");
        isLoading.value = false;
      }
    }catch(e){
      log("Exception => $e");
      isLoading.value = false;
    }
  }

  Future <void> payRequestNowReadyUI({required List<String> brandsName, required String checkoutId}) async {
    try{
      PaymentResultData paymentResultData;
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
          brandsName: brandsName,
          checkoutId: checkoutId,
          companyNameApplePayIOS: "Test Co", // applePay
          themColorHexIOS: "#000000", // FOR IOS ONLY
          setStorePaymentDetailsMode: true, // store payment details for future use
        ),
      );

      log(paymentResultData.paymentResult.toString(), name: "PAYMENT_RESULT");

      if(paymentResultData.paymentResult == PaymentResult.success){
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
        isLoading.value = false;
      }else if(paymentResultData.paymentResult == PaymentResult.error){
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
        isLoading.value = false;
      }else if(paymentResultData.paymentResult == PaymentResult.noResult) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
        isLoading.value = false;
      }
      else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
        isLoading.value = false;
      }
    }catch(e){
      debugPrint("Exception => $e");
      isLoading.value = false;
    }
    isLoading.value = false;
  }


}