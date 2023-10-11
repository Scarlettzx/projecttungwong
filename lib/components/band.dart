import 'package:project/components/user.dart';

class Band {
  User first_vocal;
  User sec_drum;
  User third_guitar;
  User fouth_bass;

  Band(
      {required this.first_vocal,
      required this.sec_drum,
      required this.third_guitar,
      required this.fouth_bass});
}
