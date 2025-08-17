import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:dompet_ku/model/local/dropdown.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';

// ignore: must_be_immutable, camel_case_types
class customDropdown extends StatefulWidget {
  String? label;
  String? title;
  IconData? icon;
  Widget? item;
  List<DropdownModel> items;
  bool isMarkShown;
  ValueChanged<dynamic> setSelectItem;
  double? dropdownWidth;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  TextStyle? titleStyle;
  double? iconSize;
  Color? iconColor;
  Color? backColor;
  Color? borderColor;
  double? borderSize;
  double? radiusSize;

  customDropdown({
    super.key,
    this.label,
    this.title,
    this.icon,
    this.item,
    required this.items,
    this.isMarkShown = true,
    required this.setSelectItem,
    this.dropdownWidth,
    this.labelStyle,
    this.hintStyle,
    this.titleStyle,
    this.iconSize,
    this.iconColor,
    this.borderColor,
    this.borderSize,
    this.radiusSize,
  });

  @override
  State<customDropdown> createState() => _customDropdownState();
}

// ignore: camel_case_types
class _customDropdownState extends State<customDropdown> {
  dynamic selectedKey;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _openDropdown();
    } else {
      _closeDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: widget.dropdownWidth ?? size.width,
              left: offset.dx,
              top: offset.dy + size.height,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, 5),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: customRoundedShadowStyle(
                      color: white,
                      size: 15,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items.map((item) {
                        final isSelected = selectedKey == item.value;
                        return InkWell(
                          onTap: () {
                            handleSelect(item.value);
                            _closeDropdown();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            color: isSelected
                                ? Colors.grey.shade100
                                : Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  child: item.item ??
                                      Row(
                                        children: [
                                          if (item.icon != null)
                                            Icon(item.icon, color: black_1),
                                          if (item.label != null)
                                            SizedBox(width: 8),
                                          if (item.label != null)
                                            Text(
                                              item.label ?? '',
                                              style: widget.titleStyle ??
                                                  bold_15_1,
                                            ),
                                        ],
                                      ),
                                ),
                                if (widget.isMarkShown && isSelected)
                                  Icon(
                                    HugeIcons.strokeRoundedCheckmarkCircle03,
                                    color: mainColor_1,
                                    size: widget.iconSize,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void handleSelect(dynamic value) {
    setState(() {
      selectedKey = selectedKey == value ? null : value;
      widget.setSelectItem(selectedKey);
    });
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items.firstWhere(
      (e) => e.value == selectedKey,
      orElse: () => DropdownModel(value: null, label: null),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label ?? '',
            style: widget.labelStyle ?? bold_12_1,
          ),
          const SizedBox(height: 10),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: customRoundedStyle(
                color: widget.backColor ?? gray_3,
                size: widget.radiusSize ?? 15,
                borderColor: widget.borderColor,
                borderSize: widget.borderSize,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: widget.item ??
                        Row(
                          children: [
                            if (widget.icon != null)
                              Icon(
                                selectedItem.icon ?? widget.icon,
                                color: widget.iconColor ?? black_1,
                                size: widget.iconSize,
                              ),
                            if (widget.title != null) SizedBox(width: 8),
                            if (widget.title != null)
                              Text(
                                selectedItem.label ?? widget.title ?? '',
                                style: selectedItem.label == null
                                    ? widget.hintStyle ?? normal_15_3
                                    : widget.titleStyle ?? bold_15_1,
                              ),
                          ],
                        ),
                  ),
                  AnimatedRotation(
                    turns: _overlayEntry != null ? 0.5 : 0.25,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      HugeIcons.strokeRoundedArrowRight01,
                      color: mainColor_1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
