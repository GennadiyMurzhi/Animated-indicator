import 'package:animated_indicator/animated_indicator_widget/labels_widget.dart';
import 'package:animated_indicator/animated_indicator_widget/scale_widget.dart';
import 'package:flutter/material.dart';

class AnimatedIndicatorWidget extends StatelessWidget {
  const AnimatedIndicatorWidget({
    super.key,
    required this.ranges,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    this.borderRadius = 15,
    this.scaleHeight = 15,
    this.backgroundColor,
  });

  final List<AnimatedIndicatorRange> ranges;
  final EdgeInsets padding;
  final double borderRadius;
  final double scaleHeight;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        children: <Widget>[
          LabelsWidget(ranges: ranges),
          const SizedBox(height: 5),
          ScaleWidget(
            ranges: _animatedIndicatorRangeToRelationRange(),
            scaleHeight: scaleHeight,
          ),
        ],
      ),
    );
  }

  List<RelationRange> _animatedIndicatorRangeToRelationRange() {
    double sum = 0;
    for (AnimatedIndicatorRange element in ranges) {
      sum = sum + element.percent;
    }

    return ranges
        .map((AnimatedIndicatorRange e) =>
            RelationRange.fromAnimatedIndicatorRange(e, sum))
        .toList();
  }
}

class AnimatedIndicatorRange {
  final String name;
  final int percent;
  final Color color;

  AnimatedIndicatorRange({
    required this.name,
    required this.percent,
    required this.color,
  });
}
