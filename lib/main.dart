import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'screen/image_screen.dart';

// Entry point of the Flutter application
void main() {
  // Runs the Flutter application starting with MyApp widget
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  // Constructor for MyApp
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a GetMaterialApp to enable GetX state management and navigation
    return GetMaterialApp(
      title: 'Flutter Demo', // Title of the application

      // Theme configuration for the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color theme to blue
      ),

      // Initial screen of the application
      home: const ClassifyScreen(),
    );
  }
}