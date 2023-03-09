import 'package:get/get.dart';
import 'package:my_grocery/controller/auth_controller.dart';
import 'package:my_grocery/service/remote_service/remote_order_service.dart';
import 'package:my_grocery/model/checkout.dart';
import 'package:my_grocery/model/order.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  final authController = Get.find<AuthController>();
  RxList<Order> orderList = List<Order>.empty(growable: true).obs;
  RxBool isOrderLoading = false.obs;

  @override
  void onInit() {
    getOrders(token: authController.getToken());
    super.onInit();
  }

  void getOrders({required String? token}) async {
    try {
      isOrderLoading(true);
      var result = await RemoteOrderService().get(token: token);
      if (result != null) {
        orderList.assignAll(orderListFromJson(result.body));
      }
    } finally {
      isOrderLoading(false);
      print(orderList.length);
    }
  }
}
