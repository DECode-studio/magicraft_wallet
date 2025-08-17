import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:universal_io/io.dart';

import 'color.dart';

enum GradientDirection {
  vertical,
  horizontal,
  diagonal,
}

BoxDecoration fabStyle(List<Color> colors) => BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: colors,
      ),
    );

BoxDecoration navStyle() => BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: black_1.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 8.0)
      ],
    );

BoxDecoration customGradientStyle({
  List<Color>? colors,
  double? borderRadiusSize,
  bool isShadow = true,
  Color shadowColor = Colors.grey,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) {
  // Set the begin and end points of the gradient based on direction
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  switch (gradientDirection) {
    case GradientDirection.horizontal:
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
      break;
    case GradientDirection.diagonal:
      begin = Alignment.topLeft;
      end = Alignment.bottomRight;
      break;
    case GradientDirection.vertical:
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
  }

  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadiusSize ?? 20),
    gradient: LinearGradient(
      colors: colors ?? [Colors.blue, Colors.blueAccent],
      begin: begin,
      end: end,
    ),
    boxShadow: isShadow == false
        ? null
        : [
            BoxShadow(
              color: shadowColor.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
  );
}

BoxDecoration mainRoundedStyle() => BoxDecoration(
      color: mainColor_1,
      borderRadius: BorderRadius.circular(20),
    );

BoxDecoration subRoundedStyle() => BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(20),
    );

BoxDecoration asyncCustomRoundedStyle({
  required Color color,
  Color? borderColor,
  double? topSize,
  double? bottomSize,
  double? borderSize,
}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(topSize ?? 20),
        topLeft: Radius.circular(topSize ?? 20),
        bottomRight: Radius.circular(bottomSize ?? 20),
        bottomLeft: Radius.circular(bottomSize ?? 20),
      ),
      border: borderColor != null
          ? Border.all(
              width: borderSize ?? 2,
              color: borderColor,
            )
          : null,
    );

BoxDecoration customRoundedStyle({
  Color? color,
  Color? borderColor,
  double? size,
  double? borderSize,
  bool isGradient = false,
  bool isBorder = false,
  List<Color>? colors,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) {
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  switch (gradientDirection) {
    case GradientDirection.horizontal:
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
      break;
    case GradientDirection.diagonal:
      begin = Alignment.topLeft;
      end = Alignment.bottomRight;
      break;
    case GradientDirection.vertical:
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
  }

  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(size ?? 20),
    border: isBorder == false
        ? null
        : isGradient == false
            ? Border.all(
                width: borderSize ?? 2,
                color: borderColor ?? mainColor_1,
              )
            : GradientBoxBorder(
                gradient: LinearGradient(
                  colors: colors ?? mainCombine,
                  begin: begin,
                  end: end,
                ),
                width: borderSize ?? 2,
              ),
    gradient: isGradient == false || (isGradient && isBorder)
        ? null
        : LinearGradient(
            colors: colors ?? mainCombine,
            begin: begin,
            end: end,
          ),
  );
}

BoxDecoration mainRoundedShadowStyle() => BoxDecoration(
      color: mainColor_1,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );

BoxDecoration subRoundedShadowStyle() => BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );

BoxDecoration customRoundedShadowStyle({
  required Color color,
  Color? shadowColor,
  Color? borderColor,
  double? size,
  double? borderSize,
  bool isGradient = false,
  bool isBorder = false,
  List<Color>? colors,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) {
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  switch (gradientDirection) {
    case GradientDirection.horizontal:
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
      break;
    case GradientDirection.diagonal:
      begin = Alignment.topLeft;
      end = Alignment.bottomRight;
      break;
    case GradientDirection.vertical:
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
  }

  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(size ?? 20),
    border: isBorder == false
        ? null
        : isGradient == false
            ? Border.all(
                width: borderSize ?? 2,
                color: borderColor ?? mainColor_1,
              )
            : GradientBoxBorder(
                gradient: LinearGradient(
                  colors: colors ?? mainCombine,
                  begin: begin,
                  end: end,
                ),
                width: borderSize ?? 2,
              ),
    gradient: isGradient == false || (isGradient && isBorder)
        ? null
        : LinearGradient(
            colors: colors ?? mainCombine,
            begin: begin,
            end: end,
          ),
    boxShadow: [
      BoxShadow(
        color: (shadowColor ?? Colors.grey).withOpacity(0.3),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}

BoxDecoration topRoundedCustomeStyle({
  required Color color,
  required double size,
  bool isShadow = false,
  Color shadowColor = gray_2,
}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(size),
      ),
      boxShadow: !isShadow
          ? null
          : [
              BoxShadow(
                color: shadowColor.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
    );

BoxDecoration bottomRoundedCustomeStyle(
  Color color,
  double size, {
  bool shadow = true,
  ImageProvider<Object>? imageProvider,
  File? imageUri,
  BoxFit? fit,
}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(size),
      ),
      boxShadow: shadow
          ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]
          : null,
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: fit ?? BoxFit.cover,
                )
              : null,
    );

BoxDecoration customeImageCardStyle({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
  Color? color,
  double? size,
  BoxFit? fit,
  bool shadow = true,
}) =>
    BoxDecoration(
      color: color ?? gray_1,
      borderRadius: BorderRadius.circular(size ?? 20),
      boxShadow: shadow
          ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]
          : null,
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: fit ?? BoxFit.cover,
                )
              : null,
    );

BoxDecoration imageCardStyle({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
  double? size,
}) =>
    BoxDecoration(
      color: gray_1,
      borderRadius: BorderRadius.circular(size ?? 20),
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
    );

BoxDecoration imageCardStyle_2({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
}) =>
    BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(20),
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
    );

BoxDecoration imageShadowCardStyle({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
}) =>
    BoxDecoration(
      color: gray_1,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
    );

BoxDecoration imageShadowCardStyle_2({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
  Color? shadowColor,
}) =>
    BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: (shadowColor ?? Colors.grey).withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
    );

BoxDecoration circleImageCard({
  ImageProvider<Object>? imageProvider,
  File? imageUri,
  BoxFit? fit,
  bool shadow = true,
  Color? shadowColor,
  Color? backColor,
}) =>
    BoxDecoration(
      color: backColor ?? white,
      borderRadius: BorderRadius.circular(500),
      boxShadow: shadow
          ? [
              BoxShadow(
                color: shadowColor ?? Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]
          : [],
      image: imageProvider != null
          ? DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            )
          : imageUri != null
              ? DecorationImage(
                  image: FileImage(
                    imageUri,
                  ),
                  fit: fit ?? BoxFit.cover,
                )
              : null,
    );

BoxDecoration circleCard({
  Color? color,
  bool useBorder = false,
  Color? borderColor,
  double? borderSize,
  bool isGradient = false,
  List<Color>? colors,
  bool isShadow = false,
  Color shadowColor = Colors.grey,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) {
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  switch (gradientDirection) {
    case GradientDirection.horizontal:
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
      break;
    case GradientDirection.diagonal:
      begin = Alignment.topLeft;
      end = Alignment.bottomRight;
      break;
    case GradientDirection.vertical:
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
  }

  return BoxDecoration(
    color: color ?? white,
    borderRadius: BorderRadius.circular(500),
    border: useBorder == false
        ? null
        : Border.all(
            width: borderSize ?? 2,
            color: borderColor ?? mainColor_1,
          ),
    gradient: isGradient == false
        ? null
        : LinearGradient(
            colors: colors ?? mainCombine,
            begin: begin,
            end: end,
          ),
    boxShadow: isShadow == false
        ? null
        : [
            BoxShadow(
              color: shadowColor.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
  );
}

BoxDecoration circleShadowCard({
  Color? color,
  Color? shadowColor,
}) =>
    BoxDecoration(
      color: color ?? white,
      borderRadius: BorderRadius.circular(500),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );

BoxDecoration customCard({Color? color, double? size}) => BoxDecoration(
      color: color ?? mainColor_1,
      borderRadius: BorderRadius.circular(size ?? 20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
