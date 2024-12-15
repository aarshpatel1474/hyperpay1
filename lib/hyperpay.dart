import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';

class HyperPay extends StatefulWidget {
  const HyperPay({super.key});

  @override
  State<HyperPay> createState() => _HyperPayState();
}

class _HyperPayState extends State<HyperPay> {
  late FlutterHyperPay flutterHyperPay;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: 'https://test.com/paymentResult', // For testing only
      paymentMode: PaymentMode.test,
      lang: 'en',
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff012F5C), // Updated AppBar color
        title: const Text(
          "HyperPay",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        // centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to HyperPay",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff012F5C),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Secure and reliable payment gateway integration. Click below to proceed to checkout.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff4A4A4A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                getCheckOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0677B8),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: SizedBox(
                width: 200,
                height: 50,
                child: !isLoading
                    ? Center(
                      child: const Text(
                                        "Proceed to Checkout",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                                        ),
                                      ),
                    )
                    : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  getCheckOut() async {
   try{
     _isLoading(true);
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
       _isLoading(false);
     }
   }catch(e){
     debugPrint("Exception => $e");
     _isLoading(false);
   }
  }

  payRequestNowReadyUI({required List<String> brandsName, required String checkoutId}) async {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
      _isLoading(false);
     }else if(paymentResultData.paymentResult == PaymentResult.error){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
       _isLoading(false);
     }else if(paymentResultData.paymentResult == PaymentResult.noResult) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${paymentResultData.paymentResult}")));
       _isLoading(false);
     }
     else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Smothing wrong!")));
       _isLoading(false);
     }
   }catch(e){
     debugPrint("Exception => $e");
     _isLoading(false);
   }
   _isLoading(false);
  }


  _isLoading(bool loading){
    setState(() {
      isLoading = false;
    });
  }


}
