import 'package:chatchy/ui/languages.dart';
import 'package:flutter/material.dart';

class CustomShape1 extends CustomPainter {
  final color;
  CustomShape1(this.color);
  @override
  void paint(Canvas canvas, Size size) {
     
       Paint paint= new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

      Path path = Path();
      path.lineTo(0, size.height);
      path.quadraticBezierTo(15, size.height - 35, 60, size.height - 35);
      path.lineTo(size.width - 50, size.height- 35);
      path.quadraticBezierTo(size.width - 15, size.height - 35, size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);

      canvas.drawPath(path, paint);

    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
  
    return true;
  }

}