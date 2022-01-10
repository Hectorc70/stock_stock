import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerCustom extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  const ShimmerCustom.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        );
  const ShimmerCustom.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          )),
    );
  }
}
