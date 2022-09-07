import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';


import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
class ActorVO extends BaseActorVO {
  // @JsonKey(name:"profile_path")
  // late String profilePath;

  @JsonKey(name: "adult")
  bool? adult;

  @JsonKey(name: "gender")
  int? gender;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "known_for")
  List<MovieVO>? knownFor;

  @JsonKey(name: "known_for_department")
  String? knownForDepartment;

  // @JsonKey(name:"name")
  // late String name;

  @JsonKey(name: "popularity")
  double? popularity;


  ActorVO(this.adult, this.gender, this.id, this.knownFor,
      this.knownForDepartment, this.popularity,String? name,String? profilePath) : super(name, profilePath);

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);

  // @override
  // String toString() {
  //   return 'ActorVO{profilePath: $profilePath, adult: $adult, id: $id,  name: $name, popularity: $popularity}';
  // }
}
