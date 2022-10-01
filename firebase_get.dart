import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetController extends GetxController {
  var starpresent = 0.0.obs;
  var fullworkhour = 0.0.obs;
  var name = "".obs;
  // starpresentCal(startp) {
  //   fullworkhour.value = double.parse((startp / 100).toStringAsFixed(1));
  //   print("flut wh ${fullworkhour}");
  //   fullworkhour.refresh();
  //   update();
  // }

  void updateget() {
    update();
  }

  void reset(reset) {
    starpresent.value = reset;
  }
}
