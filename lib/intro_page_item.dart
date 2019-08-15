import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pc_monitor/data.dart';
import 'package:pc_monitor/page_transformer.dart';
import 'package:pc_monitor/sparkline.dart';

class IntroPageItem extends StatelessWidget {
  newGraph() {
    var graph = Sparkline(
      data2: graphData[graphData.keys.elementAt(globalIndex)],
      lineWidth: 5.0,
      lineGradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.red[800], Colors.blue[200]],
      ),
    );
    graph.min = 0.0;

    if (graphData.keys.elementAt(globalIndex).toString().contains("%")) {
      graph.max = 100.0;
    } else {
      graph.max = null;
    }

    return graph;
  }

  IntroPageItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final IntroItem item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.category.toString().toUpperCase(),
        style: textTheme.caption.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 21.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item.title,
          style: textTheme.title.copyWith(
            color: Colors.black87,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var graph = new Center(
      child: new FractionallySizedBox(
        widthFactor: 0.85,
        heightFactor: 0.7,
        child: newGraph(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            graph,
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
