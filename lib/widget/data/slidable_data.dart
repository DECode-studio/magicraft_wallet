import 'package:flutter/material.dart';

class SlidableData extends StatefulWidget {
  final Widget child;
  final Function(double) onSlide;

  const SlidableData({
    Key? key,
    required this.child,
    required this.onSlide,
  }) : super(key: key);

  @override
  _SlidableDataState createState() => _SlidableDataState();
}

class _SlidableDataState extends State<SlidableData> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _slidePosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _slidePosition += details.primaryDelta!;
      widget.onSlide(_slidePosition); // Trigger event listener
    });
  }

  void _onDragEnd(DragEndDetails details) {
    _controller.forward(from: 0.0);
    _controller.addListener(() {
      setState(() {
        _slidePosition = _slidePosition * (1 - _controller.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Transform.translate(
        offset: Offset(_slidePosition, 0),
        child: widget.child,
      ),
    );
  }
}