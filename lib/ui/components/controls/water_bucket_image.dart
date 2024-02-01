import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class WaterBucketImage extends StatefulWidget {
  final double value;
  const WaterBucketImage({super.key, required this.value});

  @override
  State<WaterBucketImage> createState() => _WaterBucketImageState();
}

class _WaterBucketImageState extends State<WaterBucketImage> {
  final waterSize = const Size(126, 142);
  final bucketSize = const Size(132, 162);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: controlImageSize().height,
      width: controlImageSize().width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: waterSize.height * 0.6 - 12,
            child: LiquidCustomProgressIndicator(
              direction: Axis.vertical,
              shapePath: buildBucketPath(waterSize),
              value: widget.value,
              valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).colorScheme.tertiary),
            ),
          ),
          SvgPicture.asset(
            'assets/images/water_bucket.svg',
            width: bucketSize.width,
            height: bucketSize.height,
          )
        ],
      ),
    );
  }
}

Path buildBucketPath(Size size) {
  Path path = Path();

  path = Path();
  path.lineTo(size.width * 0.97, 0);
  path.cubicTo(
      size.width * 0.97, 0, size.width * 0.97, 0, size.width * 0.97, 0);
  path.cubicTo(
      size.width * 0.97, 0, size.width * 0.96, 0, size.width * 0.96, 0);
  path.cubicTo(
      size.width * 0.96, 0, size.width * 0.04, 0, size.width * 0.04, 0);
  path.cubicTo(
      size.width * 0.04, 0, size.width * 0.04, 0, size.width * 0.04, 0);
  path.cubicTo(size.width * 0.04, 0, size.width * 0.04, size.height * 0.01,
      size.width * 0.04, size.height * 0.01);
  path.cubicTo(size.width * 0.04, size.height * 0.01, size.width * 0.04,
      size.height * 0.01, size.width * 0.04, size.height * 0.01);
  path.cubicTo(size.width * 0.04, size.height * 0.01, size.width * 0.01,
      size.height * 0.01, size.width * 0.01, size.height * 0.01);
  path.cubicTo(size.width * 0.01, size.height * 0.01, 0, size.height * 0.01, 0,
      size.height * 0.01);
  path.cubicTo(
      0, size.height * 0.01, 0, size.height * 0.01, 0, size.height * 0.01);
  path.cubicTo(
      0, size.height * 0.01, 0, size.height * 0.03, 0, size.height * 0.03);
  path.cubicTo(
      0, size.height * 0.03, 0, size.height * 0.03, 0, size.height * 0.03);
  path.cubicTo(0, size.height * 0.03, size.width * 0.01, size.height * 0.03,
      size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.01,
      size.height * 0.03, size.width * 0.01, size.height * 0.03);
  path.cubicTo(size.width * 0.01, size.height * 0.03, size.width * 0.02,
      size.height * 0.03, size.width * 0.02, size.height * 0.04);
  path.cubicTo(size.width * 0.03, size.height * 0.04, size.width * 0.03,
      size.height * 0.05, size.width * 0.03, size.height * 0.07);
  path.cubicTo(size.width * 0.03, size.height * 0.07, size.width * 0.03,
      size.height * 0.89, size.width * 0.03, size.height * 0.89);
  path.cubicTo(size.width * 0.03, size.height * 0.95, size.width * 0.09,
      size.height, size.width * 0.16, size.height);
  path.cubicTo(size.width * 0.16, size.height, size.width * 0.85, size.height,
      size.width * 0.85, size.height);
  path.cubicTo(size.width * 0.92, size.height, size.width * 0.97,
      size.height * 0.95, size.width * 0.97, size.height * 0.89);
  path.cubicTo(size.width * 0.97, size.height * 0.89, size.width * 0.97,
      size.height * 0.06, size.width * 0.97, size.height * 0.06);
  path.cubicTo(size.width * 0.98, size.height * 0.05, size.width * 0.98,
      size.height * 0.04, size.width, size.height * 0.04);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.03,
      size.width, size.height * 0.03);
  path.cubicTo(size.width, size.height * 0.03, size.width, size.height * 0.01,
      size.width, size.height * 0.01);
  path.cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.01,
      size.width, size.height * 0.01);
  path.cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.01,
      size.width, size.height * 0.01);
  path.cubicTo(size.width, size.height * 0.01, size.width * 0.97,
      size.height * 0.01, size.width * 0.97, size.height * 0.01);
  path.cubicTo(size.width * 0.97, size.height * 0.01, size.width * 0.97,
      size.height * 0.01, size.width * 0.97, size.height * 0.01);
  path.cubicTo(size.width * 0.97, size.height * 0.01, size.width * 0.97,
      size.height * 0.01, size.width * 0.97, size.height * 0.01);
  path.cubicTo(size.width * 0.97, size.height * 0.01, size.width * 0.97, 0,
      size.width * 0.97, 0);
  path.cubicTo(
      size.width * 0.97, 0, size.width * 0.97, 0, size.width * 0.97, 0);
  path.cubicTo(
      size.width * 0.97, 0, size.width * 0.97, 0, size.width * 0.97, 0);
  path.lineTo(size.width * 0.97, size.height * 0.01);
  path.cubicTo(size.width * 0.97, size.height * 0.01, size.width * 0.97,
      size.height * 0.01, size.width * 0.97, size.height * 0.01);
  path.cubicTo(size.width * 0.97, size.height * 0.01, size.width * 0.97,
      size.height * 0.01, size.width * 0.97, size.height * 0.01);

  return path;
}
