import '../models/coloring_page.dart';

class SketchData {
  static List<ColoringPage> getColoringPages() {
    return [
      ColoringPage(
        id: '1',
        title: 'Bunga',
        imagePath: 'assets/images/bunga.jpg',
      ),
      ColoringPage(
        id: '2',
        title: 'Rumah',
        imagePath: 'assets/images/rumah.jpg',
      ),
      ColoringPage(
        id: '3',
        title: 'Mobil',
        imagePath: 'assets/images/mobil.jpg',
      ),
    ];
  }
}
