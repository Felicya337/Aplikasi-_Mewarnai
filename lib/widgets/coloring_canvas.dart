import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ColoringCanvas extends StatefulWidget {
  final String imagePath;
  final Color selectedColor;

  const ColoringCanvas({Key? key, required this.imagePath, required this.selectedColor}) : super(key: key);

  @override
  _ColoringCanvasState createState() => _ColoringCanvasState();
}

class _ColoringCanvasState extends State<ColoringCanvas> {
  List<Offset> points = <Offset>[];

  void clearDrawing() {
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox? box = context.findRenderObject() as RenderBox;
          Offset localPosition = box.globalToLocal(details.globalPosition);
          points = List.from(points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => points.add(Offset.infinite),
      child: ClipRect(
        child: CustomPaint(
          size: Size.infinite,
          painter: SketchPainter(
            points: points,
            imagePath: widget.imagePath,
            selectedColor: widget.selectedColor,
          ),
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset> points;
  final String imagePath;
  final Color selectedColor;

  SketchPainter({required this.points, required this.imagePath, required this.selectedColor});

  @override
  void paint(Canvas canvas, Size size) {
    ImageProvider imageProvider = AssetImage(imagePath);
    ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
      // Dapatkan gambar
      ui.Image image = imageInfo.image;

      // Gambar gambar di canvas
      paintImage(
        canvas: canvas,
        rect: Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        image: image,
      );
    }));

    Paint paint = Paint()
      ..color = selectedColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.imagePath != imagePath ||
        oldDelegate.selectedColor != selectedColor;
  }
}