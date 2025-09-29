import 'package:aplikasi_mewarnai/models/sketch.dart';
import 'package:flutter/material.dart';

class ColoringCanvas extends StatefulWidget {
  final String imagePath;
  final Color selectedColor;

  const ColoringCanvas({
    Key? key,
    required this.imagePath,
    required this.selectedColor,
  }) : super(key: key);

  @override
  ColoringCanvasState createState() => ColoringCanvasState();
}

class ColoringCanvasState extends State<ColoringCanvas> {
  List<Sketch> sketches = <Sketch>[];
  List<Offset> currentPoints = <Offset>[]; // Daftar titik untuk goresan saat ini

  void clearDrawing() {
    setState(() {
      sketches.clear();
      currentPoints.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) { // Tambahkan onPanStart
        setState(() {
          currentPoints = <Offset>[]; // Mulai goresan baru
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset localPosition = box.globalToLocal(details.globalPosition);
          currentPoints = List.from(currentPoints)..add(localPosition); // Tambahkan titik ke goresan saat ini
        });
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          sketches = List.from(sketches)..add(Sketch(points: currentPoints, color: widget.selectedColor)); // Tambahkan goresan ke daftar goresan dengan warna yang dipilih
          currentPoints = <Offset>[]; // Reset daftar titik untuk goresan berikutnya
        });
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomPaint(
          size: Size.infinite,
          painter: SketchPainter(
            sketches: sketches,
          ),
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Sketch> sketches;

  SketchPainter({
    required this.sketches,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final sketch in sketches) {
      Paint paint = Paint()
        ..color = sketch.color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;

      for (int i = 0; i < sketch.points.length - 1; i++) {
        if (sketch.points[i] != Offset.infinite && sketch.points[i + 1] != Offset.infinite) {
          canvas.drawLine(sketch.points[i], sketch.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}
