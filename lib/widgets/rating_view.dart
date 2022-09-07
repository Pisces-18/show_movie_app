import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/resources/colors.dart';
import '../resources/dimens.dart';

class RatingView extends StatelessWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RatingBar.builder(
        initialRating: 5.0,
        itemBuilder: (BuildContext context, int index) => const Icon(
          Icons.star,
          color: PLAY_BUTTN_COLOR,
        ),
        itemSize: MARGIN_MEDIUM_2,
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}
