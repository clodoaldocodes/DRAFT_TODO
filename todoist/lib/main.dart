import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desenhar Retângulo',
      home: DrawingPage(),
    );
  }
}

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<Rect> rectangles = [];
  Rect? currentRectangle;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      final startPoint = details.localPosition;
      currentRectangle = Rect.fromPoints(startPoint, startPoint);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final endPoint = details.localPosition;
      currentRectangle = Rect.fromPoints(currentRectangle!.topLeft, endPoint);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      rectangles.add(currentRectangle!);
      currentRectangle = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desenhar Retângulo'),
      ),
      body: GestureDetector(
        onTapDown: _onTapDown,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: CustomPaint(
          painter: MyPainter(rectangles, currentRectangle),
          child: Container(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Rect> rectangles;
  final Rect? currentRectangle;

  MyPainter(this.rectangles, this.currentRectangle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final erasePaint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;

    for (final rect in rectangles) {
      canvas.drawRect(rect, paint);
    }

    if (currentRectangle != null) {
      canvas.drawRect(
          Rect.fromPoints(
              currentRectangle!.topLeft, currentRectangle!.bottomRight),
          erasePaint);
      canvas.drawRect(
          Rect.fromPoints(
              currentRectangle!.topLeft, currentRectangle!.bottomRight),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
