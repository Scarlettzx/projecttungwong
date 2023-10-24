import 'package:get/get.dart';
import '../controller/bands_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/profile_controller.dart';

class BandService extends GetxService {
  late BandsController bandsController;
  late ProfileController profileController;
  late NotificationController notificationController;
  void init() {
    bandsController = BandsController();
    profileController = ProfileController();
    bandsController.checkBand();
    notificationController = NotificationController();
    notificationController.getNotifications();
  }
}
