import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class HitTestDetector extends SingleChildRenderObjectWidget {

  final int index;

  const HitTestDetector({
    Key? key,
    Widget? child,
    required this.index,
  }) : super(
    key: key,
    child: child,
  );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HitTestDetectorRenderBox()..index = index;
  }

  @override
  void updateRenderObject(
      BuildContext context,
      covariant HitTestDetectorRenderBox renderObject,
      ) {
    renderObject.index = index;
  }
}

class HitTestDetectorRenderBox extends RenderProxyBox {
  int index = 0;
}