import 'package:get/get.dart';
import '../controller/bands_controller.dart';
import '../controller/profile_controller.dart';

class BandService extends GetxService {
  late BandsController bandsController;
  late ProfileController profileController;
  void init() {
    bandsController = BandsController();
    profileController = ProfileController();
    bandsController.checkBand();
  }
}
