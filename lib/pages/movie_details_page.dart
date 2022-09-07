import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/title_text.dart';
import '../data/vos/credit_vo.dart';
import '../resources/dimens.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/gradient_view.dart';
import '../widgets/rating_view.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  MovieDetailsPage(this.movieId);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieModel mMovieModel = MovieModelImpl();

  MovieVO? mMovie;

  List<CreditVO>? mActorsList;
  List<CreditVO>? mCreatorsList;

  @override
  void initState() {
    super.initState();
    mMovieModel.getMovieDetails(widget.movieId).then((movie) {
      setState(() {
        mMovie = movie;
      });
    });

    mMovieModel.getCreditsByMovie(widget.movieId).then((creditsList) {
      setState(() {
        mActorsList =
            creditsList.where((credit) => credit.isActor()).toList();
        mCreatorsList =
            creditsList.where((credit) => credit.isCreator()).toList();
        debugPrint(mActorsList?.cast()[0].toString());
      });
    }).catchError((error) {
      debugPrint("Credit Error===>$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: (mMovie != null)
                ? CustomScrollView(
                    slivers: [
                      MovieDetailsSliverAppBarView(
                          () => Navigator.pop(context), mMovie),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2,
                              ),
                              child: TrailerSection(mMovie),
                            ),
                            const SizedBox(height: MARGIN_LARGE),
                            ActorsAndCreatorsSectionView(
                              MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                              "",
                              seeMoreButtonVisibility: false,
                              mActorsList: mActorsList ?? [],
                            ),
                            const SizedBox(height: MARGIN_LARGE),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2,
                              ),
                              child: AboutFilmSectionView(
                                mMovie: mMovie,
                              ),
                            ),
                            const SizedBox(height: MARGIN_LARGE),
                            (mCreatorsList != null)
                                ? ActorsAndCreatorsSectionView(
                                    MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                                    MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                                    mActorsList: mCreatorsList ?? [])
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({Key? key, required this.mMovie})
      : super(key: key);

  final MovieVO? mMovie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Original Title:",
          mMovie?.originalTitle ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Type:",
            mMovie?.genres?.map((genre) => genre.name ?? "").join(",")),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Production:",
          mMovie?.productionCountries
              ?.map((country) => country.name ?? "")
              .join(","),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Premiere:",
          mMovie?.releaseDate ?? "",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Description:",
          mMovie?.overview ?? "",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String? description;
  AboutFilmInfoView(this.label, this.description);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            label,
            style: const TextStyle(
              color: MOVIE_DETAILS_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  MovieVO? mMovie;

  TrailerSection(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
            genreList:
                mMovie?.genres?.map((genre) => genre.name ?? "").toList()),
        const SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(
          storyLine: mMovie?.overview ?? "",
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              PLAY_TRAILER_BUTTON_TEXT,
              PLAY_BUTTN_COLOR,
              const Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              RATE_MOVIE_BUTTON_TEXT,
              HOME_SCREEN_BACKGROUND_COLOR,
              const Icon(
                Icons.star,
                color: PLAY_BUTTN_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;
  MovieDetailsScreenButtonView(
    this.title,
    this.backgroundColor,
    this.buttonIcon, {
    this.isGhostButton = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_CARD_MEDIUM_2,
      ),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({Key? key, required this.storyLine}) : super(key: key);
  final String storyLine;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          storyLine,
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String>? genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMovieTimeAndGenreWidget(),
    );
  }

  List<Widget> _createMovieTimeAndGenreWidget() {
    List<Widget> widgets = [
      const Icon(
        Icons.access_time,
        color: PLAY_BUTTN_COLOR,
      ),
      const SizedBox(width: MARGIN_SMALL),
      const Text(
        "1h 39min",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: MARGIN_MEDIUM),
    ];
    widgets
        .addAll(genreList?.map((genre) => GenreChipView(genre)).toList() ?? []);
    widgets.add(
      const Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
    return widgets;
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_SMALL),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? mMovie;
  MovieDetailsSliverAppBarView(
    this.onTapBack,
    this.mMovie,
  );
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                  moveImage: mMovie?.posterPath ?? ""),
            ),
            const Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(
                  () => onTapBack(),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(
                  mMovie: mMovie,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  const MovieDetailsAppBarInfoView({Key? key, required this.mMovie})
      : super(key: key);

  final MovieVO? mMovie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
                year: mMovie?.releaseDate!.substring(0, 4) ?? ""),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingView(),
                    const SizedBox(height: MARGIN_SMALL),
                    TitleText(
                      "${mMovie?.voteCount} VOTES",
                    ),
                    const SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                const SizedBox(width: MARGIN_MEDIUM),
                Text(
                  "${mMovie?.voteAverage}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          mMovie?.title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({Key? key, required this.year}) : super(key: key);
  final String year;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTN_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          year,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  BackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapBack(),
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({Key? key, required this.moveImage})
      : super(key: key);
  final String moveImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$moveImage",
      fit: BoxFit.cover,
    );
  }
}
