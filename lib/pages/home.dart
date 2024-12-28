import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyperpay/service/home_service.dart';
import 'package:hyperpay/widget/carousel_slider.dart';
import 'package:readmore/readmore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              WidgetCarouselSlider(),
              buildTitle(),
              buildTotalAmt(),
              buildApartmentAvailableService(),
              buildApartmentDetails(),
              buildInformation(),
              buildLocation(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildTitle () {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: Text("Apartment name will goes here with two lines",maxLines: 3,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500,decoration: TextDecoration.none),)),
          Image.asset("assets/icon/ic_mark.png",height: 34.0,)

        ],
      ),
    );
  }

  Widget buildTotalAmt () {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(100.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("6000 SAR",style: TextStyle(fontSize: 20,color: Color(0xff302B63),fontWeight: FontWeight.w600,decoration: TextDecoration.none),),
          Text("Rent Now",style: TextStyle(fontSize: 16,color: Color(0xff302B63),fontWeight: FontWeight.w500,decoration: TextDecoration.none),)
        ],
      ),
    );
  }

  Widget buildApartmentAvailableService () {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 28.0),
      itemCount: HomeService.apartmentDetailsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        mainAxisExtent: Get.height * 0.100
      ), itemBuilder: (context, index) {
      return Container(
        // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 44,
              width: 44,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xff302B6312)
              ),
              child: Image.asset(HomeService.apartmentDetailsList[index]['icon']),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${HomeService.apartmentDetailsList[index]['title']}",style: TextStyle(fontSize: 12,color: Color(0xff8A919D),fontWeight: FontWeight.w400,decoration: TextDecoration.none),),
                  SizedBox(height: 4.0,),
                  Text("${HomeService.apartmentDetailsList[index]['sub_title']}",style: TextStyle(fontSize: 16,color: Color(0xff302B63),fontWeight: FontWeight.w500,decoration: TextDecoration.none),)
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }

  Widget buildApartmentDetails () {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About this apartment",style: TextStyle(fontSize: 20,color: Color(0xff302B63),fontWeight: FontWeight.w600,decoration: TextDecoration.none),),
          SizedBox(height: 12.0,),
          ReadMoreText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey,decoration: TextDecoration.none),
            trimMode: TrimMode.Line,
            trimLines: 2,
            colorClickableText: Colors.red,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildInformation () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0,vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xffEFEFFF)
      ),
      child:Column(
        children: [
            Row(
              children: [
                Icon(Icons.info,color: Color(0xff302B63),),
                SizedBox(width: 12.0,),
                Text("Regulatory Information",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff302B63),decoration: TextDecoration.none),)
              ],
            ),
            SizedBox(height: 12.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("FAL License Number",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff302B63),decoration: TextDecoration.none),),
                Text("1200010164",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff302B63),decoration: TextDecoration.none),)
              ],
            ),
          SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Advertising License Number",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff302B63),decoration: TextDecoration.none),),
                Text("2315232692",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff302B63),decoration: TextDecoration.none),)
              ],
            ),
          SizedBox(height: 33.0,),
          Image.asset("assets/icon/ic_scanner.png",height: 174,width: 174,)
        ],
      ),
    );
  }

  Widget buildLocation () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0,vertical: 16.0),
      decoration: BoxDecoration(

      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff302B63),decoration: TextDecoration.none),),
          SizedBox(height: 8.0,),
            Row(
              children: [
                Icon(Icons.location_on,color: Color(0xff302B63),),
                SizedBox(width: 8.0,),
                Expanded(child: Text("4519 Washington Ave. Manchester, Kentucky 39494 Jakarta, Indonesia",style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff302B63),decoration: TextDecoration.none),)),
                SizedBox(width: 8.0,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  child: Text("Get Direction",style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white,decoration: TextDecoration.none)),
                  decoration: BoxDecoration(
                    color: Color(0xff302B63),
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ],
            ),
          SizedBox(height: 20.0,),
          SizedBox(
            width: Get.width,
              child: Image.asset("assets/icon/ic_map.png",width: Get.width,fit: BoxFit.cover,))
        ],
      ),
    );
  }

  Widget buildBottomBar () {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0,vertical: 16.0),
      decoration: BoxDecoration(
      color: Color(0xffFFFFFF)
      ),
      child:Row(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff302B63)),
              ),
              child: Image.asset("assets/icon/ic_info.png",height: 20.0,)),
          SizedBox(width: 12.0,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xff302B63)),
              ),
              child: Text("Book A Visit",textAlign: TextAlign.center,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff302B63),decoration: TextDecoration.none),),
            ),
          ),
          SizedBox(width: 12.0,),
      Expanded(
        child: GestureDetector(
          onTap: () {
            HomeService.getCheckOut();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(colors: [
                Color(0xff0F0C29),
                Color(0xff302B63),
                Color(0xff24243E),
              ]),
              border: Border.all(color: Color(0xff302B63)),
            ),
            child: Text("Rent it Now",textAlign: TextAlign.center,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white,decoration: TextDecoration.none),),
          ),
        ),
      ),
        ],
      ),
    );
  }


}
