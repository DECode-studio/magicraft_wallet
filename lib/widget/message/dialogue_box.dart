import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

void dialogueBox({
  required String title,
  String? description,
  IconData? icon,
  required List<String> actions,
  Function(int)? onAction,
  bool isBottomSheet = false,
  TextStyle? titleStyle,
  TextStyle? descriptionStyle,
  Color? iconColor,
  double? iconSize,
}) =>
    isBottomSheet == true
        ? Get.bottomSheet(
            _modalBody(
              title: title,
              description: description,
              icon: icon,
              actions: actions,
              onAction: onAction,
              titleStyle: titleStyle,
              descriptionStyle: descriptionStyle,
              iconColor: iconColor,
              iconSize: iconSize,
            ),
            backgroundColor: backColor_3,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          )
        : Get.dialog(
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backColor_3,
              content: _modalBody(
                title: title,
                description: description,
                icon: icon,
                actions: actions,
                onAction: onAction,
                titleStyle: titleStyle,
                descriptionStyle: descriptionStyle,
                iconColor: iconColor,
                iconSize: iconSize,
              ),
            ),
            barrierDismissible: false,
          );

class _modalBody extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final List<String> actions;
  final Function(int)? onAction;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final Color? iconColor;
  final double? iconSize;

  const _modalBody({
    required this.title,
    required this.description,
    required this.icon,
    required this.actions,
    required this.onAction,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.iconColor,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                iconModal(icon: icon, color: iconColor, size: iconSize),
                icon != null
                    ? Container()
                    : const SizedBox(
                        height: 15,
                      ),
                Text(
                  title,
                  style: titleStyle ?? bold_18_2,
                  textAlign: TextAlign.center,
                ),
                if (description != null && description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      description ?? '',
                      style: descriptionStyle ?? normal_15_2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    actions.length,
                    (index) => ElevatedButton(
                      onPressed: () {
                        onAction?.call(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor_1,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Text(
                        actions[index],
                        style: normal_15_2,
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
            exitButton(),
          ],
        ),
      );
}

Widget iconModal({
  required IconData? icon,
  Color? color,
  double? size,
}) =>
    icon == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Icon(
              icon,
              size: size ?? 80,
              color: color ?? mainColor_1,
            ),
          );

Widget exitButton() => Align(
      alignment: Alignment.topLeft,
      child: CircleAvatar(
        backgroundColor: mainColor_1,
        child: IconButton(
          onPressed: Navigate.back,
          icon: Icon(
            HugeIcons.strokeRoundedCancel01,
            color: white,
          ),
        ),
      ),
    );
