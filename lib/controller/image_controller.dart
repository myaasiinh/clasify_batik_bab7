// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../utils/printlog_utils.dart';

class ClassifyController extends GetxController {
  // Reactive variable to store the selected image as a File object
  Rx<File?> image = Rx<File?>(null);

  // Reactive variable to indicate whether a process is ongoing
  RxBool busy = false.obs;

  // Reactive list to store the results of the model's predictions
  RxList recognitions = <Map>[].obs;

  // Reactive variable to store a selected value from the predictions
  RxString selected = ''.obs;

  // Instance of ImagePicker to handle image selection from the gallery or camera
  final ImagePicker _picker = ImagePicker();

  // Called when the controller is initialized; loads the ML model
  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  // Asynchronously loads the TensorFlow Lite model and its labels
  Future<void> loadModel() async {
    Tflite.close(); // Closes any previously loaded models
    try {
      await Tflite.loadModel(
        model: "asset/model9079.tflite", // Path to the ML model file
        labels: "asset/labels.txt",      // Path to the labels file
      );
    } catch (e) {
      // Logs an error message if the model fails to load
      PrintLogUtils.printLog("Failed to load the model: $e");
    }
  }

  // Allows the user to pick an image either from the camera or the gallery
  Future<void> selectImage({required bool fromCamera}) async {
    PickedFile? pickedFile = await (fromCamera
        ? _picker.getImage(source: ImageSource.camera) // Captures a photo
        : _picker.getImage(source: ImageSource.gallery)); // Selects an image

    if (pickedFile != null) {
      image.value = File(pickedFile.path); // Updates the reactive image variable
      predictImage(image.value!); // Processes the selected image with the ML model
    }
  }

  // Predicts the contents of the image using the ML model
  Future<void> predictImage(File imageFile) async {
    busy.value = true; // Indicates the process has started

    // Executes the TensorFlow Lite model on the provided image
    var results = await Tflite.runModelOnImage(
      path: imageFile.path,    // Path to the image file
      imageMean: 0.0,          // Mean normalization value
      imageStd: 255.0,         // Standard deviation normalization value
      numResults: 2,           // Maximum number of results
      threshold: 0.2,          // Confidence threshold for results
      asynch: false,           // Indicates synchronous execution
    );

    // Debug: Logs the results and their type
    PrintLogUtils.printLog("Results type: \${results.runtimeType}");
    PrintLogUtils.printLog("Results: \$results");

    // Processes and stores the results if they are valid
    if (results is List) {
      try {
        recognitions.value = results
            .where((e) => e is Map<dynamic, dynamic>) // Filters valid map objects
            .map((e) => e as Map<dynamic, dynamic>)
            .toList();
      } catch (e) {
        PrintLogUtils.printLog("Error processing results: \$e");
        recognitions.value = []; // Resets recognitions on error
      }
    } else {
      recognitions.value = []; // Resets recognitions if results are invalid
    }

    busy.value = false; // Indicates the process has ended
  }

  // Updates the selected prediction value
  void updateSelected(String? value) {
    selected.value = value ?? ''; // Updates the reactive selected variable
  }
}
