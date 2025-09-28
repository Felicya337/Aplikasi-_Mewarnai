import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatefulWidget {
  final Function(Color) onColorSelected;
  final Color selectedColor;

  const ColorPicker({
    super.key,
    required this.onColorSelected,
    required this.selectedColor,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Pilih Warna',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlockPicker(
              pickerColor: widget.selectedColor,
              onColorChanged: widget.onColorSelected,
              availableColors: const [
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.lightBlue,
                Colors.cyan,
                Colors.teal,
                Colors.green,
                Colors.lightGreen,
                Colors.lime,
                Colors.yellow,
                Colors.amber,
                Colors.orange,
                Colors.deepOrange,
                Colors.brown,
                Colors.grey,
                Colors.black,
                Colors.white,
              ],
              layoutBuilder: (context, colors, picker) {
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // Grid dengan 5 kolom
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  children: colors.map((color) => picker(color)).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
