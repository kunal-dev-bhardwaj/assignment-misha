import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddScreenController extends GetxController {
  final DatabaseReference database = FirebaseDatabase.instance.ref("items");

  var imageUrl = ''.obs;

  void setImageUrl(String url) {
    imageUrl.value = url;
  }

  Future<bool> addItem({
    required String title,
    required String description,
    required String? imageUrl,
  }) async {
    final newItem = {
      "title": title,
      "description": description,
      "imageUrl": imageUrl ?? '',
      "checked": false,
      "timestamp": ServerValue.timestamp,
    };
    try {
      final newRef = database.push();
      await newRef.set(newItem);
      Get.snackbar('Success', 'Data added successfully!');
      return true;
    } catch (error) {
      Get.snackbar('Error', 'Failed to add data: $error');
      return false;
    }
  }


  Future<String?> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        final File file = File(image.path);
        final storageRef = FirebaseStorage.instance.ref();

        final imageRef = storageRef.child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        print("Uploading image...");
        await imageRef.putFile(file);

        final downloadUrl = await imageRef.getDownloadURL();

        print("Image uploaded successfully. Download URL: $downloadUrl");

        return downloadUrl;
      } catch (e) {
        print("Error uploading image: $e");
        Get.snackbar('Error', 'Failed to upload image: $e');
        return null;
      }
    } else {
      Get.snackbar('No Image Selected', 'Please select an image to upload.');
      return null;
    }
  }
}
