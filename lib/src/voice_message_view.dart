import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/play_status.dart';
import 'package:voice_message_package/src/helpers/utils.dart';
import 'package:voice_message_package/src/voice_controller.dart';
import 'package:voice_message_package/src/widgets/noises.dart';
import 'package:voice_message_package/src/widgets/play_pause_button.dart';

/// A widget that displays a voice message view with play/pause functionality.
///
/// The [VoiceMessageView] widget is used to display a voice message with customizable appearance and behavior.
/// It provides a play/pause button, a progress slider, and a counter for the remaining time.
/// The appearance of the widget can be customized using various properties such as background color, slider color, and text styles.
///
class VoiceMessageView extends StatelessWidget {
  const VoiceMessageView(
      {super.key,
      required this.controller,
      this.backgroundColor = Colors.white,
      this.activeSliderColor = Colors.red,
      this.notActiveSliderColor = Colors.red,
      this.circlesColor = Colors.red,
      this.innerPadding = 12,
      this.cornerRadius = 20,
      // this.playerWidth = 170,
      this.size = 38,
      this.refreshIcon = const Icon(
        Icons.refresh,
        color: Colors.white,
      ),
      this.pauseIcon = const Icon(
        Icons.pause_rounded,
        color: Colors.white,
      ),
      this.playIcon = const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
      ),
      this.stopDownloadingIcon = const Icon(
        Icons.close,
        color: Colors.white,
      ),
      this.playPauseButtonDecoration,
      this.circlesTextStyle = const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      this.counterTextStyle = const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      this.playPauseButtonLoadingColor = Colors.white,
      required this.width});

  /// The controller for the voice message view.
  final VoiceController controller;

  /// The background color of the voice message view.
  final double width;
  final Color backgroundColor;

  ///
  final Color circlesColor;

  /// The color of the active slider.
  final Color activeSliderColor;

  /// The color of the not active slider.
  final Color? notActiveSliderColor;

  /// The text style of the circles.
  final TextStyle circlesTextStyle;

  /// The text style of the counter.
  final TextStyle counterTextStyle;

  /// The padding between the inner content and the outer container.
  final double innerPadding;

  /// The corner radius of the outer container.
  final double cornerRadius;

  /// The size of the play/pause button.
  final double size;

  /// The refresh icon of the play/pause button.
  final Widget refreshIcon;

  /// The pause icon of the play/pause button.
  final Widget pauseIcon;

  /// The play icon of the play/pause button.
  final Widget playIcon;

  /// The stop downloading icon of the play/pause button.
  final Widget stopDownloadingIcon;

  /// The play Decoration of the play/pause button.
  final Decoration? playPauseButtonDecoration;

  /// The loading Color of the play/pause button.
  final Color playPauseButtonLoadingColor;

  @override

  /// Build voice message view.
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final color = circlesColor;
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
          trackShape: CustomTrackShape(),
          thumbShape: SliderComponentShape.noThumb,
          minThumbSeparation: 0,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
          activeTrackColor: activeSliderColor,
          inactiveTrackColor: notActiveSliderColor),
      splashColor: Colors.transparent,
    );

    return Container(
      padding: EdgeInsets.all(innerPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: ValueListenableBuilder(
        /// update ui when change play status
        valueListenable: controller.updater,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// play pause button
              PlayPauseButton(
                controller: controller,
                color: color,
                loadingColor: playPauseButtonLoadingColor,
                size: size,
                refreshIcon: refreshIcon,
                pauseIcon: pauseIcon,
                playIcon: playIcon,
                stopDownloadingIcon: stopDownloadingIcon,
                buttonDecoration: playPauseButtonDecoration,
              ),

              ///
              /*  Expanded(
                child: _noises(newTHeme, context),
              ), */
              const SizedBox(
                width: 16,
              ),

              /// slider & noises
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _noises(newTHeme),
                    const SizedBox(height: 4),
                    Text(controller.remindingTime, style: counterTextStyle),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          );
        },
      ),
    );
  }

  SizedBox _noises(ThemeData newTHeme) => SizedBox(
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 1,
              child: Container(
                padding: EdgeInsets.only(left: .50.w(), right: .60.w()),
                color: Colors.transparent,
                child: Theme(
                  data: newTHeme,
                  child: Slider(
                    value: controller.currentMillSeconds,
                    max: controller.maxMillSeconds,
                    onChangeStart: controller.onChangeSliderStart,
                    onChanged: controller.onChanging,
                    onChangeEnd: (value) {
                      controller.onSeek(
                        Duration(milliseconds: value.toInt()),
                      );
                      controller.play();
                    },
                  ),
                ),
              ),
            ),
            IgnorePointer(
              child: SizedBox(
                child: ShaderMask(
                  blendMode: BlendMode.xor,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [backgroundColor, backgroundColor],
                      /*    blendMode: BlendMode.multiply, // Modo de mezcla */
                    ).createShader(bounds);
                  },
                  child: Noises(
                    rList: controller.randoms!,
                    activeSliderColor: notActiveSliderColor!,
                  ),
                ),
              ),
            ),
            /* /// noises
            Noises(
              rList: controller.randoms!,
              activeSliderColor: activeSliderColor,
            ),

            /// slider
            AnimatedBuilder(
              animation: CurvedAnimation(
                parent: controller.animController,
                curve: Curves.ease,
              ),
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  left: controller.animController.value,
                  child: Container(
                    width: controller.noiseWidth,
                    height: 6.w(),
                    color:
                        notActiveSliderColor ?? backgroundColor.withOpacity(.4),
                  ),
                );
              },
            ), */
          ],
        ),
      );

  Transform _changeSpeedButton(Color color) => Transform.translate(
        offset: const Offset(0, -7),
        child: GestureDetector(
          onTap: () {
            controller.changeSpeed();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              controller.speed.playSpeedStr,
              style: circlesTextStyle,
            ),
          ),
        ),
      );
}

///
/// A custom track shape for a slider that is rounded rectangular in shape.
/// Extends the [RoundedRectSliderTrackShape] class.
class CustomTrackShape extends RectangularSliderTrackShape {
  @override

  /// Returns the preferred rectangle for the voice message view.
  ///
  /// The preferred rectangle is calculated based on the current state and layout
  /// of the voice message view. It represents the area where the view should be
  /// displayed on the screen.
  ///
  /// Returns a [Rect] object representing the preferred rectangle.
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 20;
    final double trackLeft = offset.dx,
        trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(
        trackLeft + 0.5, trackTop, trackWidth - 0.5, trackHeight);
  }
}
