import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';

import '../../network/responses/get_credits_by_movie_response.dart';
import '../../persistence/daos/movie_dao.dart';


class MovieModelImpl  extends MovieModel{

  MovieDataAgent mDataAgent=RetrofitDataAgentImpl();
  static final MovieModelImpl _singleton=MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  ///Daos
  MovieDao mMovieDao=MovieDao();
  GenreDao mGenreDao=GenreDao();
  ActorDao mActorDao=ActorDao();

  //Network
  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies=movies.map((movie) {
        movie.isNowPlaying=true;
        movie.isTopRated=false;
        movie.isPopular=false;
        return movie;
      }).toList();
      mMovieDao.saveAllMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getPopularMovies(int page) {
    return mDataAgent.getPopularMovies(page)?.then((movies) async{
      List<MovieVO> popularMovies=movies.map((movie) {
        movie.isPopular=true;
        movie.isTopRated=false;
        movie.isNowPlaying=false;
        return movie;
      }).toList();
      mMovieDao.saveAllMovies(popularMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(page) {
    return mDataAgent.getTopRatedMovies(page)?.then((movies) async {
      List<MovieVO> topRatedMovies=movies.map((movie) {
        movie.isTopRated=true;
        movie.isNowPlaying=false;
        movie.isPopular=false;
        return movie;
      }).toList();
      mMovieDao.saveAllMovies(topRatedMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mDataAgent.getGenres()?.then((genres) async {
      mGenreDao.saveAllGenres(genres);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<ActorVO>>? getActors(int page) {
    return mDataAgent.getActors(page)?.then((actors) async {
      mActorDao.saveAllActors(actors);
      return Future.value(actors);
    });
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  @override
  Future<List<CreditVO>>? getActorsByMovie(int movieId) {
    return mDataAgent.getActorsByMovie(movieId);
  }
  @override
  Future<List<CreditVO>>? getCreatorsByMovie(int movieId) {
    return mDataAgent.getCreatorsByMovie(movieId);
  }

  //Database
  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isTopRated ?? true)
    .toList());
  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isNowPlaying ?? true)
    .toList());
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    return Future.value(mMovieDao
    .getAllMovies()
    .where((movie) => movie.isPopular ?? true)
    .toList());
  }

  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
   return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

}