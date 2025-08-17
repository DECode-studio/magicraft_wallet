import 'package:flutter/material.dart';

class ChatBubbleWithTail extends StatelessWidget {
  final Widget child;
  final bool isSender;

  const ChatBubbleWithTail({
    Key? key,
    required this.child,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      children: [
        Positioned(
          left: isSender ? null : -10,
          right: isSender ? -10 : null,
          bottom: 0,
          child: CustomPaint(
            painter: TailPainter(isSender: isSender),
          ),
        ),
        child,
      ],
    );
  }
}

class TailPainter extends CustomPainter {
  final bool isSender;

  TailPainter({required this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSender ? Colors.blueAccent : Colors.grey[300]!
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isSender) {
      // Tail untuk pengirim (kanan)
      path.moveTo(0, 10);
      path.quadraticBezierTo(-10, 0, -20, 10); // Membuat lengkungan ke kanan atas
      path.quadraticBezierTo(-10, 5, 0, 20); // Kembali ke bawah
    } else {
      // Tail untuk penerima (kiri)
      path.moveTo(0, 10);
      path.quadraticBezierTo(10, 0, 20, 10); // Membuat lengkungan ke kiri atas
      path.quadraticBezierTo(10, 5, 0, 20); // Kembali ke bawah
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
