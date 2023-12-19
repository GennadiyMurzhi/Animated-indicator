import 'package:flutter/material.dart';

class ExampleButtons extends StatelessWidget {
  const ExampleButtons({
    super.key,
    required this.examplesCount,
    required this.onChooseExampleData,
    required this.onChooseRandomData,
  });

  final int examplesCount;
  final void Function(int index) onChooseExampleData;
  final void Function(int?) onChooseRandomData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            examplesCount,
            (int index) => _ExampleButton(
              onPressed: () => onChooseExampleData(index),
              label: 'Data ${index + 1}',
            ),
          ),
        ),
        _RandomButton(onChooseRandomData: onChooseRandomData),
      ],
    );
  }
}

class _RandomButton extends StatefulWidget {
  final void Function(int?) onChooseRandomData;

  const _RandomButton({required this.onChooseRandomData});

  @override
  State<StatefulWidget> createState() => _RandomButtonState();
}

class _RandomButtonState extends State<_RandomButton> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 50,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: textController,
          ),
        ),
        _ExampleButton(
          onPressed: () =>
              widget.onChooseRandomData(int.tryParse(textController.text)),
          label: 'Random Data',
        )
      ],
    );
  }
}

class _ExampleButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  const _ExampleButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
