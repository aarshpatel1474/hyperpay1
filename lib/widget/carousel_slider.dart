import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyperpay/service/home_service.dart';

class WidgetCarouselSlider extends StatefulWidget {
  const WidgetCarouselSlider({super.key});

  @override
  State<WidgetCarouselSlider> createState() => _WidgetCarouselSliderState();
}

class _WidgetCarouselSliderState extends State<WidgetCarouselSlider> {


  RxInt currentPage = 0.obs;
  RxBool isFav = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: HomeService.imageList.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32.0),
                  bottomLeft: Radius.circular(32.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32.0),
                  bottomLeft: Radius.circular(32.0),
                ),
                child: Image.network(
                  HomeService.imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            initialPage: 0,
            viewportFraction: 1.0,
            height: Get.height * 0.45,
            onPageChanged: (index, reason) {
              currentPage.value = index;
            },
          ),
        ),
        Positioned(
          top: 60.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white38,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isFav.value = !isFav.value;
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff302B63),
                  ),
                  child: Obx(()=>Icon(
                    isFav.value ? Icons.favorite_rounded :
                    Icons.favorite_border,
                    color: Colors.white,
                  )),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          left: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(HomeService.imageList.length, (index1) {
              return Obx(()=>Container(
                height: 8.0,
                width: 8.0,
                margin: EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage.value == index1 ? Colors.white : Colors.white38
                ),
              ));
            },)
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 20.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Obx(()=>Text(
              "${currentPage.value + 1} / ${HomeService.imageList.length}",
              style: TextStyle(fontSize: 12.0,decoration: TextDecoration.none,color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
