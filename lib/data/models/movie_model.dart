import 'package:movie_app/data/vos/movie_vo.dart';
import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';


abstract class MovieModel{
  //Network
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getPopularMovies(int page);
  Future<List<MovieVO>>? getTopRatedMovies(page);
  Future<List<GenreVO>>? getGenres();
  Future<List<MovieVO>>? getMoviesByGenre(int genreId);
  Future<List<ActorVO>>? getActors(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<CreditVO>>? getActorsByMovie(int movieId);
  Future<List<CreditVO>>? getCreatorsByMovie(int movieId);

  //Database

  Future<List<MovieVO>> getTopRatedMoviesFromDatabase();
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>> getPopularMoviesFromDatabase();
  Future<List<GenreVO>> getGenresFromDatabase();
  Future<List<ActorVO>> getAllActorsFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);
}