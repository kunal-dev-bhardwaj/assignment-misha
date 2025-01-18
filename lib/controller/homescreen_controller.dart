import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class HomescreenController extends GetxController {
  var itemList = <Map<String, dynamic>>[].obs;
  RxBool isLoading= false.obs;
  final DatabaseReference database = FirebaseDatabase.instance.ref("items");

  @override
  void onReady() {
    // TODO: implement onReady
    fetchItems();

    super.onReady();
  }



  String formatTimestamp(int timestamp) {
     final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
     final formattedDate = DateFormat('d MMMM yyyy, h:mm a').format(date);
    return formattedDate;
  }


  void fetchItems() {
    isLoading.value = true;


    database.orderByKey().onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);

        itemList.value = data.entries
            .map((e) => {
          "id": e.key,
          "title": e.value["title"],
          "checked": e.value["checked"],
          "description": e.value["description"],
          "timestamp": e.value["timestamp"],
        }).toList()..sort((a, b) {

            final aTime = a['timestamp'] ?? 0;
            final bTime = b['timestamp'] ?? 0;
            return bTime.compareTo(aTime);
          });

        itemList.refresh();
      } else {
        itemList.value = [];
      }

      isLoading.value = false;
    }).onError((error) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch data: $error');
    });
  }


  // void deleteItem(String id) {
  //   database.child(id).remove();
  // }

  Future<void> deleteItem(String id) async {
    try {
      // Remove the item from Firebase
      await database.child(id).remove();

      // Now, update the local list to reflect the deletion
      itemList.removeWhere((item) => item['id'] == id);
      itemList.refresh(); // Notify the UI to rebuild the list

      Get.snackbar('Success', 'Item deleted successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete item: $error');
    }
  }



  void toggleCheckbox(String id, bool value) {
    database.child(id).update({"checked": value});
  }

  var selectedItem = {}.obs;


  void setSelectedItem(Map<String, dynamic> item) {
    selectedItem.value = item;
    debugPrint('${item['description']} dataaaa===>>');
  }

  Future<bool> showConfirmationDialog(BuildContext context,String id) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                deleteItem(id);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

}
