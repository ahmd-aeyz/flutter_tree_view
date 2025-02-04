import 'package:flutter/material.dart';

import 'lines_painter.dart';
import 'tree_node.dart';
import 'tree_node_scope.dart';
import 'tree_view_theme.dart';
import 'dart:math' as math;
/// Widget responsible for indenting nodes and drawing lines (if enabled).
class LinesWidget extends StatelessWidget {
  /// Creates a [LinesWidget].
  const LinesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final treeNodeScope = TreeNodeScope.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    late final child = SizedBox(
      width: treeNodeScope.indentation,
      height: double.infinity,
    );

    switch (treeNodeScope.theme.lineStyle) {
      case LineStyle.scoped:
        return Transform(
            alignment: Alignment.center,
            transform: isRTL
                ? (Matrix4.identity()..rotateY(-math.pi))
                : Matrix4.identity(),
            child: CustomPaint(
              painter: LinesPainter(
                linesToBeDrawn: treeNodeScope.node.scopedLines,
                theme: treeNodeScope.theme,
              ),
              child: child,
            ));

      case LineStyle.connected:
        return Transform(
            alignment: Alignment.center,
            transform: isRTL
                ? (Matrix4.identity()..rotateY(-math.pi))
                : Matrix4.identity(),
            child: CustomPaint(
              painter: LinesPainter(
                linesToBeDrawn: treeNodeScope.node.connectedLines,
                theme: treeNodeScope.theme,
              ),
              child: child,
            ));

      case LineStyle.disabled:
      default:
        return child;
    }
  }
}
