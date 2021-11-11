import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart';

class WidgetCachedImageError extends StatelessWidget {
  final String icon;

  WidgetCachedImageError(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(icon ?? IMAGES.LOGO_APP),
    );
  }
}

class WidgetLineContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.1)),
      width: AppValue.widths,
      height: 5,
    );
  }
}


class WidgetHeightLive extends StatelessWidget {
  final Color color;
  final double height, width;

  const WidgetHeightLive({this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(color: color),
    );
  }
}

class WidgetContainerImage extends StatelessWidget {
  final double width, height, padding;
  final String image;
  final BoxDecoration boxDecoration;
  final Color colorImage;

  const WidgetContainerImage(
      {this.width = 30, this.height = 30, this.padding = 0, this.image, this.boxDecoration, this.colorImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: boxDecoration,
      padding: EdgeInsets.all(padding),
      child: Center(
          child: Image.asset(image, color: colorImage,)
      ),
    );
  }
}

class WidgetContainerIcon extends StatelessWidget {
  final double width, height;
  final IconData icon;
  final Color backgroundColor, iconColor;

  const WidgetContainerIcon(
      {this.width = 35, this.height = 35, this.icon, this.backgroundColor = COLORS.PRIMARY_COLOR, this.iconColor = COLORS.WHITE});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: Center(child: Icon(icon, color: iconColor))
    );
  }
}

class WidgetContainerColor extends StatelessWidget {
  final double width, height;
  final Color color;

  const WidgetContainerColor({this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

class WidgetContainerText extends StatelessWidget {
  final String title;
  final double width;
  final TextStyle style;

  const WidgetContainerText({this.title, this.width, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? null,
      padding: EdgeInsets.only(top: 15),
      child: Text(title, style: style ?? TextStyle(color: COLORS.GREEN)),
    );
  }
}


class WidgetCircleProgress extends StatelessWidget {
  final Color backgroundColor;
  final Color valueColor;

  const WidgetCircleProgress({Key key, this.backgroundColor, this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(5),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? COLORS.PRIMARY_COLOR),
        backgroundColor: backgroundColor ?? Colors.grey,
      ),
    );
  }
}

class WidgetContainerCenter extends StatelessWidget {
  final double width, height;
  final Widget child;
  final BoxDecoration boxDecoration;

  WidgetContainerCenter({this.width, this.height, this.child, this.boxDecoration});

  @override
  Widget build(BuildContext context) =>
      Container(
        width: width,
        height: height,
        decoration: boxDecoration,
        child: Center(child: child),
      );
}


class WidgetCircleColorContainer extends StatelessWidget {
  final Color color;
  final double width, height;
  final Widget child;
  final AlignmentGeometry alignment;

  WidgetCircleColorContainer(
      {this.color, this.width, this.height, this.child, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: alignment ?? null,
      width: width,
      height: height,
      child: child ?? null,
    );
  }
}