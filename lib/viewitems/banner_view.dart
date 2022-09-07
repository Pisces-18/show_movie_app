import 'package:flutter/material.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import '../data/vos/movie_vo.dart';
import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final Function(int) onTapBanner;
  final MovieVO? mMovie;
  BannerView(this.onTapBanner,this.mMovie);
   @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BannerImageView(mImageUrl: mMovie?.posterPath?? "",),
        ),
        const Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(mMovieName: mMovie?.title?? "",),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(()=>onTapBanner(mMovie?.id?? 0),),
        ),
      ],
    );
  }
}

class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key, required this.mMovieName,
  }) : super(key: key);
  final String mMovieName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        MARGIN_MEDIUM_2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(
            mMovieName,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Official Review",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({Key? key, required this.mImageUrl}) : super(key: key);

  final String mImageUrl;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$mImageUrl",
      fit: BoxFit.cover,
    );
  }
}
