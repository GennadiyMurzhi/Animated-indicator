import 'package:animated_indicator/animated_indicator_widget/animated_indicator_widget.dart';
import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  final List<AnimatedIndicatorRange> ranges;

  const LabelsWidget({super.key, required this.ranges});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: MediaQuery.of(context).size.width * 0.05,
      children: ranges
            .map((AnimatedIndicatorRange e) => LabelWidget(range: e))
            .toList(),
    );
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.range});

  final AnimatedIndicatorRange range;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: range.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          '${range.name} ${range.percent} %',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
