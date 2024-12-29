// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../utils/printlog_utils.dart';

class ClassifyController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  RxBool busy = false.obs;
  RxList recognitions = <Map>[].obs;
  RxString selected = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "asset/model9079.tflite",
        labels: "asset/labels.txt",
      );
    } catch (e) {
      PrintLogUtils.printLog("Failed to load the model: $e");
    }
  }

  Future<void> selectImage({required bool fromCamera}) async {
    PickedFile? pickedFile = await (fromCamera
        ? _picker.getImage(source: ImageSource.camera)
        : _picker.getImage(source: ImageSource.gallery));
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      predictImage(image.value!);
    }
  }

Future<void> predictImage(File imageFile) async {
  busy.value = true;

  // Run the model on the image
  var results = await Tflite.runModelOnImage(
    path: imageFile.path,
    imageMean: 0.0,
    imageStd: 255.0,
    numResults: 2,
    threshold: 0.2,
    asynch: false,
  );

  // Debugging: Print results
  print("Results type: ${results.runtimeType}");
  print("Results: $results");

  // Safely handle results
  if (results is List) {
    try {
      recognitions.value = results
          .where((e) => e is Map<dynamic, dynamic>) // Filter only valid maps
          .map((e) => e as Map<dynamic, dynamic>)
          .toList();
    } catch (e) {
      print("Error processing results: $e");
      recognitions.value = [];
    }
  } else {
    recognitions.value = [];
  }

  busy.value = false;
}


  void updateSelected(String? value) {
    selected.value = value ?? '';
  }
}
