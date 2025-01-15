import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AddScreenController extends GetxController {
  final DatabaseReference database = FirebaseDatabase.instance.ref("items");

  void addItem(String title) {
    final newItem = {"title": title, "checked": false};
    print('added');
    database.push().set(newItem).then((value) {
      Get.back();
    },);
  }

}
