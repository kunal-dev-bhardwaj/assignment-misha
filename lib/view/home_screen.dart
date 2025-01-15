import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kunal_assignment_mishainfotech/controller/homescreen_controller.dart';
import 'package:kunal_assignment_mishainfotech/view/add_data_screen.dart';


class HomeScreen extends StatelessWidget {
  final HomescreenController controller = Get.put(HomescreenController());
  final TextEditingController inputController = TextEditingController();


  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      floatingActionButton:
      FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
          Get.to(AddDataScreen());
      }),
      body: Column(
        children: [

          Expanded(
            child: Obx(() {
              if (controller.itemList.isEmpty) {
                return const Center(child: Text('No items yet!'));
              }
              return ListView.builder(
                itemCount: controller.itemList.length,
                itemBuilder: (context, index) {
                  final item = controller.itemList[index];
                  return ListTile(
                    trailing: Checkbox(
                      value: item['checked'],
                      onChanged: (value) {
                        controller.toggleCheckbox(item['id'], value!);
                      },
                    ),
                    title: Text(item['title'],
                      style: TextStyle(
                      decoration: item['checked']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                    ),
                    ),
                  );
                },
              );
            }),
          ),

        ],
      ),
    );
  }
}
