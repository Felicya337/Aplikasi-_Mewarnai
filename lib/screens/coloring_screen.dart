import 'package:flutter/material.dart';
import '../models/coloring_page.dart';
import '../widgets/color_picker.dart';
import '../widgets/coloring_canvas.dart';

class ColoringScreen extends StatefulWidget {
  final ColoringPage coloringPage;

  const ColoringScreen({super.key, required this.coloringPage});

  @override
  State<ColoringScreen> createState() => _ColoringScreenState();
}

class _ColoringScreenState extends State<ColoringScreen> {
  Color selectedColor = Colors.red;
  final GlobalKey<_ColoringCanvasState> _canvasKey = GlobalKey();

  void clearCanvas() {
    _canvasKey.currentState?.clearDrawing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coloringPage.title,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: clearCanvas,
            icon: const Icon(Icons.clear, color: Colors.white),
            tooltip: 'Hapus Gambar',
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ColoringCanvas(
                  key: _canvasKey,
                  imagePath: widget.coloringPage.imagePath,
                  selectedColor: selectedColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Warna Dipilih: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ColorPicker(
                selectedColor: selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
