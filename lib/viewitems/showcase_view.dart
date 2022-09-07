import 'package:flutter/material.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/title_text.dart';
import '../data/vos/movie_vo.dart';
import '../widgets/play_button_view.dart';

class ShowCaseView extends StatelessWidget {
 final Function(int) onTapShowcase;
 final MovieVO? mMovie;
 ShowCaseView(this.onTapShowcase, this.mMovie,);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: MARGIN_MEDIUM_2,
      ),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "$IMAGE_BASE_URL${mMovie?.posterPath}",
              fit: BoxFit.cover,
            ),
          ),
           Align(
            alignment: Alignment.center,
            child: PlayButtonView(() => onTapShowcase(mMovie?.id?? 0),),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(
                MARGIN_MEDIUM_2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    mMovie?.title?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM),
                  TitleText("12 June 2019")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
