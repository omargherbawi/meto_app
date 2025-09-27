import 'package:get/get.dart';
import 'package:meto_application/core/services/hive_service.dart';

class DependencyInjection {
  static void init() {
    Get.put<HiveServices>(HiveServices(), permanent: true);
  }
}
