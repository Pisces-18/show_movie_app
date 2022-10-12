import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';

import '../../data/vos/credit_vo.dart';

part 'get_credits_by_movie_response.g.dart';
@JsonSerializable()
class GetCreditsByMovieResponse{
  @JsonKey(name: "id")
   int? id;

  @JsonKey(name: "cast")
   List<CreditVO>? cast;

  @JsonKey(name: "crew")
  List<CreditVO>? crew;

  GetCreditsByMovieResponse(this.id, this.cast,this.crew);

  factory GetCreditsByMovieResponse.fromJson(Map<String,dynamic> json)=>_$GetCreditsByMovieResponseFromJson(json);//Casting data from network with json format to Vos

  Map<String,dynamic> toJson()=>_$GetCreditsByMovieResponseToJson(this);//Casting to json format

}