import 'package:get/get.dart';
import 'package:hyperpay/controller/home_controller.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
  }

}