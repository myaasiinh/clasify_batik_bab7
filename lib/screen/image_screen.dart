import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/image_controller.dart';
import '../widget/image_preview_widget.dart';

class ClassifyScreen extends StatelessWidget {
  const ClassifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassifyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classify Object'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.image, color: Theme.of(context).primaryColor),
            onPressed: () => controller.selectImage(fromCamera: false),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Theme.of(context).primaryColor),
            onPressed: () => controller.selectImage(fromCamera: true),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Obx(() {
        return controller.image.value == null
            ? const Center(child: Text("No Image Selected"))
            : ImagePreview(
                image: controller.image.value!,
                recognitions: List<Map<dynamic, dynamic>>.from(controller.recognitions), // Cast recognitions to the expected type
                selected: controller.selected.value,
                onSelected: controller.updateSelected,
              );
      }),
    );
  }
}
