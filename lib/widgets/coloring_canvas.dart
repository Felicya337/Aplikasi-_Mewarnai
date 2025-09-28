import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatelessWidget {
  final Function(Color) onColorSelected;
  final Color selectedColor;

  const ColorPicker({
    super.key,
    required this.onColorSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: BlockPicker(
        pickerColor: selectedColor,
        onColorChanged: onColorSelected,
        availableColors: [
          Colors.red,
          Colors.pink,
          Colors.purple,
          Colors.deepPurple,
          Colors.indigo,
          Colors.blue,
          Colors.cyan,
          Colors.teal,
          Colors.green,
          Colors.lightGreen,
          Colors.yellow,
          Colors.orange,
          Colors.brown,
          Colors.grey,
          Colors.black,
        ],
      ),
    );
  }
}
