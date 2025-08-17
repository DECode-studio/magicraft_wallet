import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/color.dart';

class AnimatedBottomBarItem {
  final IconData icon;
  final String label;
  final Color? activeColor;
  final Color? inactiveColor;

  AnimatedBottomBarItem({
    required this.icon,
    required this.label,
    this.activeColor,
    this.inactiveColor,
  });
}

class AnimatedBottomBarWithNotch extends StatefulWidget {
  final List<AnimatedBottomBarItem> items;
  final Color backgroundColor;
  final Color dotColor;
  final double topLeftRadius;
  final double topRightRadius;
  final int selectedIndex;
  final bool isShadow;
  final Function(int index) onItemSelected;

  const AnimatedBottomBarWithNotch({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.backgroundColor = white,
    this.dotColor = mainColor_1,
    this.topLeftRadius = 32.0,
    this.topRightRadius = 32.0,
    this.isShadow = false,
    this.selectedIndex = 0,
  });

  @override
  State<AnimatedBottomBarWithNotch> createState() =>
      _AnimatedBottomBarWithNotchState();
}

class _AnimatedBottomBarWithNotchState extends State<AnimatedBottomBarWithNotch>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _currentIndex = widget.selectedIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: _currentIndex.toDouble(),
      end: _currentIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateToIndex(int index) {
    _animation = Tween<double>(
      begin: _currentIndex.toDouble(),
      end: index.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    setState(() => _currentIndex = index);
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.topLeftRadius),
          topRight: Radius.circular(widget.topRightRadius),
        ),
        boxShadow: widget.isShadow == false
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, -10),
                ),
              ],
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: ButtonNotch(
                  bgColor: widget.backgroundColor,
                  dotColor: widget.dotColor,
                  itemCount: widget.items.length,
                  selectedIndex: _animation.value,
                  topLeftRadius: widget.topLeftRadius,
                  topRightRadius: widget.topRightRadius,
                ),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(widget.items.length, (index) {
                  final item = widget.items[index];
                  final isActive = index == _currentIndex;

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        _animateToIndex(index);
                        widget.onItemSelected(index);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 12),
                          Icon(
                            item.icon,
                            size: 24,
                            color: isActive
                                ? (item.activeColor ?? mainColor_1)
                                : (item.inactiveColor ?? Colors.grey[600]),
                          ),
                          isActive ? Container() : const SizedBox(height: 6),
                          isActive
                              ? Container()
                              : Text(
                                  item.label,
                                  style: TextStyle(
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    fontSize: 12,
                                    color: isActive
                                        ? (item.activeColor ?? mainColor_1)
                                        : (item.inactiveColor ??
                                            Colors.grey[600]),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonNotch extends CustomPainter {
  final Color bgColor;
  final Color dotColor;
  final int itemCount;
  final double selectedIndex;
  final double topLeftRadius;
  final double topRightRadius;

  ButtonNotch({
    required this.bgColor,
    required this.dotColor,
    required this.itemCount,
    required this.selectedIndex,
    this.topLeftRadius = 0.0,
    this.topRightRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint_1 = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final paint_2 = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    final itemWidth = size.width / itemCount;
    final dotX = (selectedIndex + 0.5) * itemWidth;
    final notchHeight = 25.0;
    final notchWidth = 60.0;
    final notchStart = dotX - notchWidth / 2;
    final notchEnd = dotX + notchWidth / 2;
    final controlDistance = 20.0;

    final path = Path();

    path.moveTo(0, size.height);

    path.lineTo(0, topLeftRadius);
    if (topLeftRadius > 0) {
      path.quadraticBezierTo(
        0,
        0,
        topLeftRadius,
        0,
      );
    }

    if (notchStart > topLeftRadius) {
      path.lineTo(notchStart, 0);
    }

    path.quadraticBezierTo(
      notchStart + 10,
      0,
      notchStart + 15,
      notchHeight * 0.3,
    );

    path.cubicTo(
      dotX - controlDistance,
      notchHeight * 0.4,
      dotX - 10,
      notchHeight,
      dotX,
      notchHeight,
    );

    path.cubicTo(
      dotX + 10,
      notchHeight,
      dotX + controlDistance,
      notchHeight * 0.4,
      notchEnd - 15,
      notchHeight * 0.3,
    );

    path.quadraticBezierTo(
      notchEnd - 10,
      0,
      notchEnd,
      0,
    );

    if (notchEnd < size.width - topRightRadius) {
      path.lineTo(size.width - topRightRadius, 0);
    }

    if (topRightRadius > 0) {
      path.quadraticBezierTo(
        size.width,
        0,
        size.width,
        topRightRadius,
      );
    } else {
      path.lineTo(size.width, 0);
    }

    path.lineTo(size.width, size.height);

    path.close();

    canvas.drawPath(path, paint_1);

    final dotPoint = Offset(dotX, notchHeight * 0.4);
    canvas.drawCircle(dotPoint, 8, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ButtonNotch &&
        (oldDelegate.selectedIndex != selectedIndex ||
            oldDelegate.bgColor != bgColor ||
            oldDelegate.dotColor != dotColor ||
            oldDelegate.topLeftRadius != topLeftRadius ||
            oldDelegate.topRightRadius != topRightRadius);
  }
}
