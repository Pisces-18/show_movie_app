// import 'package:json_annotation/json_annotation.dart';
//
// part 'movie_of_actor_vo.g.dart';
// @JsonSerializable()
// class MovieOfActorVO{
//   @JsonKey(name: "adult")
//   late bool adult;
//
//   @JsonKey(name: "backdrop_path")
//   late String backDropPath;
//
//   @JsonKey(name: "genre_ids")
//   late List<int> genreIds;
//
//   @JsonKey(name: "id")
//   late int id;
//
//   @JsonKey(name: "media_type")
//   late String mediaType;
//
//   @JsonKey(name: "original_language")
//   late String originalLanguage;
//
//   @JsonKey(name: "original_title")
//   late String originalTitle;
//
//   @JsonKey(name: "overview")
//   late String overview;
//
//   @JsonKey(name: "poster_path")
//   late String posterPath;
//
//   @JsonKey(name: "release_date")
//   late String releaseDate;
//
//   @JsonKey(name: "title")
//   late String title;
//
//   @JsonKey(name: "video")
//   late bool video;
//
//   @JsonKey(name: "vote_average")
//   late double voteAverage;
//
//   @JsonKey(name: "vote_count")
//   late int voteCount;
//
//   MovieOfActorVO(
//       this.adult,
//       this.backDropPath,
//       this.genreIds,
//       this.id,
//       this.mediaType,
//       this.originalLanguage,
//       this.originalTitle,
//       this.overview,
//       this.posterPath,
//       this.releaseDate,
//       this.title,
//       this.video,
//       this.voteAverage,
//       this.voteCount);
//
//   factory MovieOfActorVO.fromJson(Map<String,dynamic> json)=>_$MovieOfActorVOFromJson(json);//Casting data from network with json format to Vos
//
//   Map<String,dynamic> toJson()=>_$MovieOfActorVOToJson(this);//Casting to json format
//
// }