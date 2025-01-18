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
            Text(
              ' Created At:- ${controller.formatTimestamp(controller.selectedItem['timestamp'])}',
              style:const TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 16),
               Text(
                controller.selectedItem['title'],
                style:const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              HtmlWidget(controller.selectedItem['description'] ?? 'No description available')

            ),
          ],
        ),
      ),
    );
  }
}
