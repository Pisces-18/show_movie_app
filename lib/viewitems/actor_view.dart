import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import '../data/vos/actor_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {
  const ActorView({Key? key, required this.mActor}) : super(key: key);

  final BaseActorVO? mActor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: MARGIN_MEDIUM,
      ),
      width: ACTOR_LIST_ITE_WIDTH,
      child: Stack(
        children:  [
          Positioned.fill(
            child: ActorImageView(aImageUrl: mActor?.profilePath?? "",),
          ),
          const Padding(
            padding: EdgeInsets.all(
              MARGIN_MEDIUM,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(name: mActor?.name?? "",),
          ),
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({Key? key, required this.aImageUrl}) : super(key: key);
  final String? aImageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$aImageUrl",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  const ActorNameAndLikeView({Key? key, required this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
           Text(
            name?? "",
            style: const TextStyle(
              fontSize: TEXT_REGULAR,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
