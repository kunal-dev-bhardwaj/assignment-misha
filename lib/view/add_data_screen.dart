import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../controller/add_screen_controller.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class AddDataScreen extends StatelessWidget {
  AddDataScreen({super.key});

  final AddScreenController controller = Get.put(AddScreenController());
  final TextEditingController inputController = TextEditingController();
  final HtmlEditorController descriptionController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input for Title
              TextFormField(
                controller: inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter item title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              HtmlEditor(
                controller: descriptionController,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Your HTML content here",
                  initialText: "<p>Enter your description here</p>",
                ),
                otherOptions: OtherOptions(
                  height: 300,
                ),
              ),
              const SizedBox(height: 16),

              // Image Uploader
              ElevatedButton.icon(
                onPressed: () async {
                  final downloadUrl = await controller.uploadImage();
                  if (downloadUrl != null) {
                    controller.setImageUrl(downloadUrl);
                    Get.snackbar('Success', 'Image uploaded successfully!');
                  }
                },
                icon: const Icon(Icons.upload),
                label: const Text('Upload Image'),
              ),
              const SizedBox(height: 16),

              // Add Button
              ElevatedButton(
                onPressed: () {
                  if (inputController.text.isNotEmpty) {
                    descriptionController.getText().then((value) {
                      controller.addItem(
                        title: inputController.text,
                        description: value,
                        imageUrl: controller.imageUrl.value,
                      );
                      inputController.clear();
                      descriptionController.clear();
                    });
                  } else {
                    Get.snackbar(
                        'Error', 'Please fill all fields and upload an image.');
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
