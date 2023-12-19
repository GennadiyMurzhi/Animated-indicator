import 'package:animated_indicator/animated_indicator_widget/animated_indicator_widget.dart';
import 'package:flutter/material.dart';

class ScaleWidget extends StatefulWidget {
  const ScaleWidget({
    super.key,
    required this.ranges,
    required this.scaleHeight,
  });

  final List<RelationRange> ranges;
  final double scaleHeight;

  @override
  State<ScaleWidget> createState() => _ScaleWidgetState();
}

class _ScaleWidgetState extends State<ScaleWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animations = widget.ranges
        .map((e) => Tween(
              begin: e.percent,
              end: e.percent,
            ).animate(_animationController))
        .toList();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ScaleWidget oldWidget) {
    if (oldWidget.ranges.length == widget.ranges.length) {
      _animations = List<Animation<double>>.generate(
        widget.ranges.length,
        (int index) => Tween(
          begin: oldWidget.ranges[index].percent,
          end: widget.ranges[index].percent,
        ).animate(_animationController),
      );
      _animationController.value = 0;
      _animationController.animateTo(1, curve: Curves.ease);
    } else {
      _animations = widget.ranges
          .map((e) => Tween(
                begin: e.percent,
                end: e.percent,
              ).animate(_animationController))
          .toList();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scaleHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.scaleHeight / 2),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return _DrawScaleWidget(
              animationValues: _animationValues(_animations),
              ranges: widget.ranges,
            );
          },
        ),
      ),
    );
  }

  List<double> _animationValues(List<Animation<double>> animations) {
    return animations.map((Animation<double> e) => e.value).toList();
  }
}

class RelationRange {
  final double percent;
  final Color color;

  RelationRange({
    required this.percent,
    required this.color,
  });

  factory RelationRange.fromAnimatedIndicatorRange(
          AnimatedIndicatorRange range, double sum) =>
      RelationRange(
        percent: range.percent / sum,
        color: range.color,
      );
}

class _DrawScaleWidget extends LeafRenderObjectWidget {
  const _DrawScaleWidget({
    required this.animationValues,
    required this.ranges,
  });

  final List<double> animationValues;
  final List<RelationRange> ranges;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderDrawScaleWidget(
      animationValues: animationValues,
      ranges: ranges,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderDrawScaleWidget renderObject) {
    renderObject.ranges = ranges;
    renderObject.animationValues = animationValues;
  }
}

class _RenderDrawScaleWidget extends RenderBox {
  _RenderDrawScaleWidget({
    required List<double> animationValues,
    required List<RelationRange> ranges,
  })  : _animationValues = animationValues,
        _ranges = ranges,
        assert(animationValues.length == ranges.length);

  late List<double> _animationValues;
  late List<RelationRange> _ranges;

  set animationValues(List<double> values) {
    _animationValues = values;

    markNeedsPaint();
  }

  set ranges(List<RelationRange> ranges) {
    _ranges = ranges;

    markNeedsPaint();
  }

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final List<double> dxValues = <double>[];
    for (int i = 0; i < _animationValues.length; i++) {
      if (i == 0) {
        dxValues.add(size.width * _animationValues[i]);
      } else {
        dxValues.add(dxValues[i - 1] + size.width * _animationValues[i]);
      }
    }

    canvas.save();

    for (int i = 0; i < _ranges.length; i++) {
      Paint paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.strokeCap = StrokeCap.square;
      paint.color = _ranges[i].color;

      final Path path = Path();

      final double radius = size.height / 2;
      final double height = offset.dy + size.height;
      if (i == 0) {
        final double radius = size.height / 2;
        path.moveTo(offset.dx, offset.dy);
        path.arcToPoint(Offset(offset.dx, height),
            radius: Radius.circular(radius), clockwise: false);
        path.lineTo(offset.dx + dxValues[i], height);
        path.lineTo(offset.dx + dxValues[i], offset.dy);
        path.close();
      } else if (i == _ranges.length - 1) {
        final double endDx = offset.dx + dxValues[i];
        path.moveTo(offset.dx + dxValues[i - 1], offset.dy);
        path.lineTo(endDx, offset.dy);
        path.arcToPoint(Offset(endDx, height), radius: Radius.circular(radius));
        path.lineTo(offset.dx + dxValues[i - 1], height);
        path.close();
      } else {
        path.moveTo(offset.dx + dxValues[i - 1], offset.dy);
        path.lineTo(offset.dx + dxValues[i], offset.dy);
        path.lineTo(offset.dx + dxValues[i], height);
        path.lineTo(offset.dx + dxValues[i - 1], height);
        path.close();
      }

      canvas.drawPath(path, paint);
    }

    canvas.restore();
  }
}
