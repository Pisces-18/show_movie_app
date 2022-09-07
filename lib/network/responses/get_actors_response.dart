import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/actor_vo.dart';

part 'get_actors_response.g.dart';

@JsonSerializable()
class GetActorsResponse{
  @JsonKey(name: "page")
  int? page;

  @JsonKey(name:"results")
  List<ActorVO>? results;

  GetActorsResponse( this.page,this.results);

  factory GetActorsResponse.fromJson(Map<String,dynamic> json)=>_$GetActorsResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$GetActorsResponseToJson(this);
}