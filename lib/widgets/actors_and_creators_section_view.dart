import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import '../data/vos/actor_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/actor_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String tileText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<BaseActorVO>? mActorsList;


  ActorsAndCreatorsSectionView(this.tileText, this.seeMoreText,
      {this.seeMoreButtonVisibility = true, required this.mActorsList, });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: const EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: TitleTextWithSeeMoreView(
              tileText,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
              SizedBox(
                  height: BEST_ACTORS_HEIGHT,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                    ),
                    children: mActorsList
                        ?.map((actor) => ActorView(
                              mActor: actor,
                            ))
                        .toList()?? [],
                  ),
                )

        ],
      ),
    );
  }
}
