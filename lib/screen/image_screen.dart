import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import '../controller/image_controller.dart';
import '../widget/image_preview_widget.dart';

class ClassifyScreen extends StatelessWidget {
  const ClassifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the ClassifyController using GetX for state management
    final controller = Get.put(ClassifyController());

    return Scaffold(
      appBar: AppBar(
        // AppBar title
        title: const Text('Classify Object'),

        // Action buttons for selecting images from the gallery or camera
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.image, color: Theme.of(context).primaryColor), // Gallery icon
            onPressed: () => controller.selectImage(fromCamera: false), // Select from gallery
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Theme.of(context).primaryColor), // Camera icon
            onPressed: () => controller.selectImage(fromCamera: true), // Capture from camera
          ),
        ],

        // AppBar styling
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      // Main body of the screen
      body: Obx(() {
        // Reactive widget that updates when the controller's state changes
        return controller.image.value == null
            ? const Center(child: Text("No Image Selected")) // Show message if no image is selected
            : ImagePreview(
                image: controller.image.value!, // Pass the selected image
                recognitions: List<Map<dynamic, dynamic>>.from(controller.recognitions), // Cast recognitions to the expected type
                selected: controller.selected.value, // Current selected recognition
                onSelected: controller.updateSelected, // Callback to update selection
              );
      }),
    );
  }
}
