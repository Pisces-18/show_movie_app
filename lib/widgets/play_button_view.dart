import 'package:flutter/material.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class PlayButtonView extends StatelessWidget {
  final Function onTabButton;
  PlayButtonView(this.onTabButton);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabButton(),
      child: const Icon(
        Icons.play_circle_fill,
        size: BANNER_PLAY_BUTTON_SIZE,
        color: PLAY_BUTTN_COLOR,
      ),
    );
  }
}
