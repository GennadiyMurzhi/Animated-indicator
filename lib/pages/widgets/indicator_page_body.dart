import 'package:animated_indicator/animated_indicator_widget/animated_indicator_widget.dart';
import 'package:animated_indicator/pages/widgets/example_buttons.dart';
import 'package:flutter/material.dart';

class IndicatorPageBody extends StatelessWidget {
  const IndicatorPageBody({
    super.key,
    this.chosenIndex,
    required this.examplesCount,
    required this.onChooseExampleData,
    required this.onChooseRandomData,
    required this.indicatorRanges,
  });

  final int? chosenIndex;
  final int examplesCount;
  final void Function(int index) onChooseExampleData;
  final void Function(int?) onChooseRandomData;
  final List<AnimatedIndicatorRange> indicatorRanges;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: <Widget>[
            AnimatedIndicatorWidget(ranges: indicatorRanges),
            const SizedBox(height: 15),
            ExampleButtons(
              examplesCount: examplesCount,
              onChooseExampleData: onChooseExampleData,
              onChooseRandomData: onChooseRandomData,
            ),
          ],
        ),
      ),
    );
  }
}
