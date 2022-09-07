import 'package:flutter/material.dart';
import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimens.dart';
import '../widgets/rating_view.dart';

class MovieView extends StatelessWidget {

  final Function(int) onTapMovie;
  final MovieVO? mMovie;
   MovieView(this.onTapMovie,this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: MARGIN_MEDIUM,
      ),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              onTapMovie(mMovie?.id?? 0);
            },
            child: Image.network(
              "$IMAGE_BASE_URL${mMovie?.posterPath}",
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
           Expanded(
             child: Text(
              mMovie?.title?? "",
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600,
              ),
          ),
           ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Text(
                "8.9",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingView(),
            ],
          )
        ],
      ),
    );
  }
}
