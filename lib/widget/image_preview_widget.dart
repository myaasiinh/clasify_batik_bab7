import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreview extends StatelessWidget {
  final File image;
  final List<Map<dynamic, dynamic>> recognitions; // Use explicit type for clarity
  final String selected;
  final ValueChanged<String?> onSelected;

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: ListView(
            children: <Widget>[
              Image.file(image),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Detected Objects',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recognitions.length,
                itemBuilder: (context, index) {
                  final recognition = recognitions[index];
                  final label = recognition['label'] as String? ?? 'Unknown';
                  final confidence = recognition['confidence'] as double? ?? 0.0;

                  return Card(
                    child: RadioListTile<String>(
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: selected,
                      value: label,
                      onChanged: onSelected,
                      title: Text(
                        label,
                        style: const TextStyle(fontSize: 16.0),
                      ),
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
