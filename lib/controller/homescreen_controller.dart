import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class HomescreenController extends GetxController {
  var itemList = <Map<String, dynamic>>[].obs;
  final DatabaseReference database = FirebaseDatabase.instance.ref("items");

  @override
  void onReady() {
    // TODO: implement onReady
    fetchItems();
    super.onReady();
  }

  void fetchItems() {
    database.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      itemList.value = data.entries
          .map((e) => {"id": e.key, "title": e.value["title"], "checked": e.value["checked"]})
          .toList();
    });
  }

  void toggleCheckbox(String id, bool value) {
    database.child(id).update({"checked": value});
  }
}
