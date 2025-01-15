import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kunal_assignment_mishainfotech/controller/homescreen_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class DataDisplayScreen extends StatelessWidget {
  final HomescreenController controller = Get.find<HomescreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Text(
                controller.selectedItem['title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            SizedBox(height: 16),

            // Display the description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                final description = controller.selectedItem['description'] ?? 'No description available';
                debugPrint("${controller.selectedItem['title']} descriptionn");
                return HtmlWidget(description);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
