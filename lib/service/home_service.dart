import 'package:get/get.dart';
import 'package:hyperpay/controller/home_controller.dart';

class HomeService {


  static final HomeController _homeController = Get.find();





  static RxList get imageList => _homeController.imageList;
  static RxList get apartmentDetailsList => _homeController.apartmentDetailsList;


  static Future<void> getCheckOut () async {
    await _homeController.getCheckOut();
  }




}