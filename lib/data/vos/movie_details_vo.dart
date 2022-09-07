// import 'package:json_annotation/json_annotation.dart';
// import 'package:movie_app/data/vos/collection_vo.dart';
// import 'package:movie_app/data/vos/genre_vo.dart';
// import 'package:movie_app/data/vos/production_company_vo.dart';
// import 'package:movie_app/data/vos/production_country_vo.dart';
// import 'package:movie_app/data/vos/spoken_language_vo.dart';
// part 'movie_details_vo.g.dart';
//
// @JsonSerializable()
// class MovieDetailsVO{
//   @JsonKey(name: "adult")
//    bool? adult;
//
//   @JsonKey(name: "backdrop_path")
//    String? backDropPath;
//
//   @JsonKey(name: "belongs_to_collection")
//    CollectionVO? belongsToCollection;
//
//   @JsonKey(name: "budget")
//   late double budget;
//
//   @JsonKey(name: "genres")
//   late List<GenreVO> genres;
//
//   @JsonKey(name: "homepage")
//   late String homePage;
//
//   // @JsonKey(name: "genre_ids")
//   // late List<int> genreIds;
//
//   @JsonKey(name: "id")
//   late int id;
//
//   @JsonKey(name: "imdb_id")
//   late String imdbId;
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
//   @JsonKey(name: "popularity")
//   late double popularity;
//
//   @JsonKey(name: "poster_path")
//   late String posterPath;
//
//   @JsonKey(name: "production_companies")
//   late List<ProductionCompanyVO> productionCompanies;
//
//   @JsonKey(name: "production_countries")
//   late List<ProductionCountryVO> productionCountries;
//
//   @JsonKey(name: "release_date")
//   late String releaseDate;
//
//   @JsonKey(name: "revenue")
//   late int revenue;
//
//   @JsonKey(name: "runtime")
//   late int runtime;
//
//   @JsonKey(name: "spoken_languages")
//   late List<SpokenLanguageVO> spokenLanguages;
//
//   @JsonKey(name: "status")
//   late String status;
//
//   @JsonKey(name: "tagline")
//   late String tagline;
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
//
//   MovieDetailsVO(
//       this.adult,
//       this.backDropPath,
//       this.belongsToCollection,
//       this.budget,
//       this.genres,
//       this.homePage,
//       this.id,
//       this.imdbId,
//       this.originalLanguage,
//       this.originalTitle,
//       this.overview,
//       this.popularity,
//       this.posterPath,
//       this.productionCompanies,
//       this.productionCountries,
//       this.releaseDate,
//       this.revenue,
//       this.runtime,
//       this.spokenLanguages,
//       this.status,
//       this.tagline,
//       this.title,
//       this.video,
//       this.voteAverage,
//       this.voteCount);
//
//   factory MovieDetailsVO.fromJson(Map<String,dynamic> json)=>_$MovieDetailsVOFromJson(json);//Casting data from network with json format to Vos
//
//   Map<String,dynamic> toJson()=>_$MovieDetailsVOToJson(this);//Casting to json format
//
// // @override
// // String toString() {
// //   return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
// // }
// }