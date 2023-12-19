import 'dart:math';

import 'package:animated_indicator/animated_indicator_widget/animated_indicator_widget.dart';
import 'package:animated_indicator/pages/widgets/indicator_page_body.dart';
import 'package:flutter/material.dart';

class IndicatorPage extends StatefulWidget {
  const IndicatorPage({super.key});

  @override
  State<IndicatorPage> createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {
  int? _chosenIndex = 0;
  late List<List<AnimatedIndicatorRange>> _exampleData;
  late List<AnimatedIndicatorRange> _chosenData;

  @override
  void initState() {
    _exampleData = <List<AnimatedIndicatorRange>>[
      <AnimatedIndicatorRange>[
        AnimatedIndicatorRange(
          name: 'Body',
          percent: 33,
          color: Colors.lightGreen,
        ),
        AnimatedIndicatorRange(
          name: 'Mind',
          percent: 50,
          color: Colors.lightBlue,
        ),
        AnimatedIndicatorRange(
          name: 'Spirit',
          percent: 70,
          color: Colors.lime,
        ),
      ],
      <AnimatedIndicatorRange>[
        AnimatedIndicatorRange(
          name: 'Body',
          percent: 10,
          color: Colors.lightGreen,
        ),
        AnimatedIndicatorRange(
          name: 'Mind',
          percent: 100,
          color: Colors.lightBlue,
        ),
        AnimatedIndicatorRange(
          name: 'Spirit',
          percent: 20,
          color: Colors.lime,
        ),
      ],
      <AnimatedIndicatorRange>[
        AnimatedIndicatorRange(
          name: 'Body',
          percent: 15,
          color: Colors.lightGreen,
        ),
        AnimatedIndicatorRange(
          name: 'Mind',
          percent: 35,
          color: Colors.lightBlue,
        ),
        AnimatedIndicatorRange(
          name: 'Spirit',
          percent: 50,
          color: Colors.lime,
        ),
        AnimatedIndicatorRange(
          name: 'Soul',
          percent: 10,
          color: Colors.purple,
        ),
      ],
      <AnimatedIndicatorRange>[
        AnimatedIndicatorRange(
          name: 'Body',
          percent: 30,
          color: Colors.lightGreen,
        ),
        AnimatedIndicatorRange(
          name: 'Mind',
          percent: 25,
          color: Colors.lightBlue,
        ),
        AnimatedIndicatorRange(
          name: 'Spirit',
          percent: 25,
          color: Colors.lime,
        ),
        AnimatedIndicatorRange(
          name: 'Soul',
          percent: 20,
          color: Colors.purple,
        ),
      ],
    ];
    _chosenData = _exampleData[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndicatorPageBody(
        chosenIndex: _chosenIndex,
        examplesCount: _exampleData.length,
        onChooseExampleData: _onChooseExampleData,
        onChooseRandomData: _onChooseRandomData,
        indicatorRanges: _chosenData,
      ),
    );
  }

  void _onChooseExampleData(int index) {
    _chosenIndex = index;
    _chosenData = _exampleData[index];
    setState(() {});
  }

  void _onChooseRandomData(int? count) {
    if (count != null && count > 0) {
      final Random random = Random();
      _chosenData = List<AnimatedIndicatorRange>.generate(
        count,
        (int index) => AnimatedIndicatorRange(
          name: 'Test ${index + 1}: ',
          percent: random.nextInt(50),
          color: Colors.primaries[index < Colors.primaries.length
              ? index
              : Colors.primaries.length - 1],
        ),
      );

      _chosenIndex = null;
      setState(() {});
    }
  }
}
