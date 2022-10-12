import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';


import '../../persistence/hive_constants.dart';
import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO,adapterName: "ActorVOAdapter")
class ActorVO extends BaseActorVO {
  // @JsonKey(name:"profile_path")
  // late String profilePath;

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "gender")
  @HiveField(1)
  int? gender;

  @JsonKey(name: "id")
  @HiveField(2)
  int? id;

  @JsonKey(name: "known_for")
  @HiveField(3)
  List<MovieVO>? knownFor;

  @JsonKey(name: "known_for_department")
  @HiveField(4)
  String? knownForDepartment;

  // @JsonKey(name:"name")
  // late String name;

  @JsonKey(name: "popularity")
  @HiveField(5)
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
