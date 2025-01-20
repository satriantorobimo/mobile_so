import 'package:flutter/material.dart';

class AssetNotFoundContainer extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const AssetNotFoundContainer({
    Key? key,
    this.text = 'Asset Not Found',
    this.width = 200,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: BubblePainter(),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 10), // Adjust for the pointer space
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    // Main rectangle with rounded corners
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height - 10),
        const Radius.circular(4),
      ),
    );

    // Triangle pointer at bottom left
    path.moveTo(20, size.height - 10); // Start from the bottom of the rectangle
    path.lineTo(30, size.height); // Point of the triangle
    path.lineTo(40, size.height - 10); // Back to the rectangle
    path.close();

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
