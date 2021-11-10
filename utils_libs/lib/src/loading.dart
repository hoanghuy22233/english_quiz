import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TrailLoading extends StatelessWidget {
  final double? height;
  final double? width;
  const TrailLoading({Key? key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: Lottie.asset(
          'assets/lottie/loading.json',
        ),
      ),
    );
  }
}

class TrailError extends StatelessWidget {
  final double? height;
  final double? width;
  const TrailError({Key? key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: Lottie.asset(
          'assets/lottie/44656_error.json',
        ),
      ),
    );
  }
}
