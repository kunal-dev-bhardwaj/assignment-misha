import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          .map((e) => {"id": e.key, "title": e.value["title"], "checked": e.value["checked"],"description":e.value["description"]})
          .toList();
    });
  }

  void deleteItem(String id) {
    database.child(id).remove();
  }

  void toggleCheckbox(String id, bool value) {
    database.child(id).update({"checked": value});
  }

  var selectedItem = {}.obs;


  void setSelectedItem(Map<String, dynamic> item) {
    selectedItem.value = item;
    debugPrint('${item['description']} dataaaa===>>');
  }

  void showDeleteConfirmationDialog(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteItem(itemId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item deleted')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
