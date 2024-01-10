import 'package:get/get.dart';

import 'logic.dart';

class OverDateReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OverDateReminderLogic());
  }
}
