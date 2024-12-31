import 'package:flutter/material.dart'; 
import 'dart:io';

class ImagePreview extends StatelessWidget {
  // File representing the selected image
  final File image;

  // List of recognitions returned by the ML model
  final List<Map<dynamic, dynamic>> recognitions; // Explicit type for clarity

  // Currently selected recognition label
  final String selected;

  // Callback to handle selection changes
  final ValueChanged<String?> onSelected;

  // Constructor for initializing required parameters
  const ImagePreview({
    super.key,
    required this.image,
    required this.recognitions,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // Aligns children to stretch horizontally
      children: <Widget>[
        Expanded(
          flex: 7, // Occupies a major portion of the vertical space
          child: ListView(
            children: <Widget>[
              // Displays the selected image
              Image.file(image),

              // Section header for detected objects
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Detected Objects',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),

              // List of detected objects with confidence scores
              ListView.builder(
                shrinkWrap: true, // Ensures the list only takes up necessary space
                physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                itemCount: recognitions.length, // Number of detected objects
                itemBuilder: (context, index) {
                  final recognition = recognitions[index]; // Current recognition

                  // Retrieve label and confidence values, with defaults for null safety
                  final label = recognition['label'] as String? ?? 'Unknown';
                  final confidence = recognition['confidence'] as double? ?? 0.0;

                  return Card(
                    // Card containing the recognition details and selection control
                    child: RadioListTile<String>(
                      activeColor: Theme.of(context).primaryColor, // Active selection color
                      groupValue: selected, // Current selected value
                      value: label, // Value for this RadioListTile
                      onChanged: onSelected, // Callback when selection changes

                      // Displays the label
                      title: Text(
                        label,
                        style: const TextStyle(fontSize: 16.0),
                      ),

                      // Displays the confidence score
                      subtitle: Text(
                        'Confidence: ${(confidence * 100).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
