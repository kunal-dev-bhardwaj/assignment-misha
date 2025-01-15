import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_screen_controller.dart';


class AddDataScreen extends StatelessWidget {
   AddDataScreen({super.key});
   AddScreenController controller=Get.put(AddScreenController());
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: inputController,
                    validator: (value) {
                      if(value!.isEmpty){

                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter item',
                    ),
                  ),
                ),
                const SizedBox(width: 10),

              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              if (inputController.text.isNotEmpty) {
                controller.addItem(inputController.text);
                inputController.clear();
              }
            },
            child: const Text('Add'),
          ),
          Spacer(),

        ],
      ),
    );
  }
}
