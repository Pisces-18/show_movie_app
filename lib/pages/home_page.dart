import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/banner_view.dart';
import '../viewitems/showcase_view.dart';
import '../widgets/actors_and_creators_section_view.dart';
import '../widgets/see_more_text.dart';
import '../widgets/title_text.dart';
import '../widgets/title_text_with_see_more_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel mMovieModel = MovieModelImpl();

  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMovies;
  List<GenreVO>? mGenreList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMovieList;
  List<MovieVO>? mMoviesByGenreList;

  @override
  void initState() {
    super.initState();

    ///Now Playing Movies
    mMovieModel.getNowPlayingMovies(1).then((movieList) {
      setState(() {
        mNowPlayingMovieList = movieList;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Popular Movies
    mMovieModel.getPopularMovies(1).then((movieLst) {
      setState(() {
        mPopularMovies = movieLst;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres
    mMovieModel.getGenres().then((genreList) {
      setState(() {
        mGenreList = genreList;

        ///Movies By Genre
        _getMoviesByGenreAndRefresh(mGenreList?.first.id?? 0);
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Showcases
    mMovieModel.getTopRatedMovies(1).then((movieList) {
      setState(() => mShowCaseMovieList = movieList);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors
    mMovieModel.getActors(1).then((actorList) {
      setState(() => mActors = actorList);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void _getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      setState(() => mMoviesByGenreList = moviesByGenre);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.menu,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: 0,
              bottom: 0,
              right: MARGIN_MEDIUM_2,
            ),
            child: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(
                  (movieId) => _navigateToMovieDetailsScreen(context,movieId), mPopularMovies?.take(10).toList()?? []),
              const SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(
                (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                mNowPlayingMovieList?? [],
              ),
              const SizedBox(height: MARGIN_LARGE),
              const CheckMovieShowTimesSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                genreList: mGenreList?? [],
                 mMoviesByGenreList: mMoviesByGenreList?? [], onTapGenre: (index)=>_getMoviesByGenreAndRefresh(index),
              ),
              const SizedBox(height: MARGIN_LARGE),
              ShowcasesSection((movieId) => _navigateToMovieDetailsScreen(context,movieId),
                  mShowCaseMovieList?? []),
              const SizedBox(height: MARGIN_LARGE),
              ActorsAndCreatorsSectionView(
                BEST_ACTORS_TITLE,
                BEST_ACTORS_SEE_MORE,
                mActorsList: mActors?? [],

              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context,int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(movieId),
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  const GenreSectionView(
    this.onTapMovie, {
    Key? key,
    required this.genreList,
    required this.mMoviesByGenreList, required this.onTapGenre,
  }) : super(key: key);

  final List<GenreVO>? genreList;
  final Function(int) onTapMovie;
  final List<MovieVO>? mMoviesByGenreList;
  final Function(int) onTapGenre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length?? 0,
            child: TabBar(
              onTap: (index){
                onTapGenre(genreList??[][index].id?? 0);
              },
              isScrollable: true,
              indicatorColor: PLAY_BUTTN_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  ?.map(
                    (genre) => Tab(
                      child: Text(genre.name?? ""),
                    ),
                  )
                  .toList()??[],
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView((movieId) {
            onTapMovie(movieId);
          }, mMoviesByGenreList??[]),
        ),
      ],
    );
  }
}

class CheckMovieShowTimesSectionView extends StatelessWidget {
  const CheckMovieShowTimesSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      padding: const EdgeInsets.all(
        MARGIN_LARGE,
      ),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTN_COLOR,
              )
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  final Function(int) onTapShowcase;
  final List<MovieVO>? mShowCaseMovieList;
  ShowcasesSection(this.onTapShowcase, this.mShowCaseMovieList);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: TitleTextWithSeeMoreView(
            SHOW_CASES_TITLE,
            SHOW_CASES_SEE_MORE,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        (mShowCaseMovieList !=null )
            ? SizedBox(
                height: SHOW_CASES_HEIGHT,
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: mShowCaseMovieList
                      ?.map((showCaseMovie) =>
                          ShowCaseView((movieId) => onTapShowcase(movieId), showCaseMovie))
                      .toList()?? [],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;
  BestPopularMoviesAndSerialsSectionView(
      this.onTapMovie, this.mNowPlayingMovieList);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: TitleText(
            MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView((movieId) {
          onTapMovie(movieId);
        }, mNowPlayingMovieList?? []),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO>? movieList;
  HorizontalMovieListView(this.onTapMovie, this.movieList);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height/3,
        child: (movieList != null)
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                ),
                itemCount: movieList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return MovieView(
                          (movieId) {
                   onTapMovie(movieId);
                  }, movieList?[index]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? mPopularMovies;

  BannerSectionView(onTapBanner, this.mPopularMovies);

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  onTapBanner(movieId) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId,)));
  // _BannerSectionViewStat(this.onTapBanner);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.mPopularMovies != null)
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: PageView(
                  onPageChanged: (page) {
                    setState(() {
                      _position = page.toDouble();
                    });
                  },
                  children: widget.mPopularMovies
                      ?.map((popularMovie) =>
                          BannerView((movieId) => onTapBanner(movieId), popularMovie))
                      .toList()?? [],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        DotsIndicator(
          dotsCount: 10,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTN_COLOR,
          ),
        )
      ],
    );
  }
}
