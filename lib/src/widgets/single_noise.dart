import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/utils.dart';

/// A widget that represents a single noise.
///
/// This widget is used to display a single noise in the UI.
/// It is a stateful widget, meaning it can change its state over time.
class SingleNoise extends StatefulWidget {
  const SingleNoise({
    super.key,
    required this.activeSliderColor,
/*     required this.height, */
    required this.total,
    required this.index,
  });

  /// The color of the active slider.
  final Color activeSliderColor;

  /// The height of the noise.
/*   final double height; */
  final int total;
  final int index;
  @override
  State<SingleNoise> createState() => _SingleNoiseState();
}

class _SingleNoiseState extends State<SingleNoise> {
  late double height;

  @override
  void initState() {
    super.initState();

    // Determinar si el índice está dentro de los primeros o últimos 5 elementos
    bool isInEdgeRange = widget.index < 3 || widget.index >= widget.total - 4;

    // Si está en los primeros o últimos 5, generar un valor pequeño
    if (isInEdgeRange) {
      height = (5);
    } else {
      // Generar un valor para el resto de los elementos
      height = (5.74.w() * math.Random().nextDouble()) + .26.w();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*   margin: EdgeInsets.symmetric(horizontal: .2.w()), */
      width: .56.w(),
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: widget.activeSliderColor),
    );
  }
}
