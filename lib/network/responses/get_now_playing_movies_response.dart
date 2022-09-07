//
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../data/vos/date_vo.dart';
// import '../../data/vos/movie_vo.dart';
// part 'get_now_playing_movies_response.g.dart';
// @JsonSerializable()
// class GetNowPlayingMoviesResponse{
//   @JsonKey(name: "dates")
//   late DateVO dates;
//
//   @JsonKey(name: "page")
//   late int page;
//
//   @JsonKey(name: "results")
//   late List<MovieVO> results;
//
//   GetNowPlayingMoviesResponse(this.dates,this.page,this.results);
//
//   factory GetNowPlayingMoviesResponse.fromJson(Map<String,dynamic> json)=>_$GetNowPlayingMoviesResponseFromJson(json);
//
//   Map<String,dynamic> toJson()=>_$GetNowPlayingMoviesResponseToJson(this);
// }