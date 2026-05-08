import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final bool isPremium;

  UserDTO({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    this.isPremium = false,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
  Map<String, dynamic> json() => _$UserDTOToJson(this);
}
