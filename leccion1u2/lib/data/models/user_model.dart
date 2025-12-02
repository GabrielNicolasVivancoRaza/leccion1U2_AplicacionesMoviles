import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? 'Sin nombre',
      username: json['username']?.toString() ?? 'Sin username',
      email: json['email']?.toString() ?? 'Sin email',
    );
  }
}
