import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desenho de Retângulo',
      home: DrawRectangle(),
    );
  }
}

class DrawRectangle extends StatefulWidget {
  @override
  _DrawRectangleState createState() => _DrawRectangleState();
}

class _DrawRectangleState extends State<DrawRectangle> {
  Offset? _minPoint;
  Offset? _maxPoint;

  void _handleTapDown(TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      if (_minPoint == null) {
        _minPoint = localOffset;
      } else if (_maxPoint == null) {
        _maxPoint = localOffset;
      } else {
        _minPoint = localOffset;
        _maxPoint = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: _handleTapDown,
        child: CustomPaint(
          painter: RectanglePainter(_minPoint, _maxPoint),
          child: Container(),
        ),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  final Offset? _minPoint;
  final Offset? _maxPoint;

  RectanglePainter(this._minPoint, this._maxPoint);

  @override
  void paint(Canvas canvas, Size size) {
    if (_minPoint == null || _maxPoint == null) {
      return;
    }

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double width = (_maxPoint!.dx - _minPoint!.dx).abs();
    double height = (_maxPoint!.dy - _minPoint!.dy).abs();

    double size = width < height ? width : height;

    Rect rect = Rect.fromPoints(
        _minPoint!, Offset(_minPoint!.dx + size, _minPoint!.dy + size));

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(RectanglePainter oldDelegate) {
    return oldDelegate._minPoint != _minPoint ||
        oldDelegate._maxPoint != _maxPoint;
  }
}
