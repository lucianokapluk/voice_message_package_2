import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/utils.dart';
import 'package:voice_message_package/src/widgets/single_noise.dart';

/// A widget that represents a collection of noises.
///
/// This widget is used to display a collection of noises in the UI.
/// It is typically used in the context of a voice message player.
class Noises extends StatelessWidget {
  const Noises({
    super.key,
    required this.rList,
    required this.activeSliderColor,
  });

  /// A list of noises value.
  final List<double> rList;

  /// The color of the active slider.
  final Color activeSliderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w(),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: rList
            .map(
              (entry) => SingleNoise(
                activeSliderColor: activeSliderColor,
                /*   height: entry.value, // El valor correspondiente de la lista */
              ),
            )
            .toList(),
      ),
    );
  }
}
