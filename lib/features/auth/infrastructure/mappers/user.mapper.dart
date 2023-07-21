part of'./../../../features.dart';

class UserMapper {

  static User userJsonToEntity(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        fullName: json["fullName"],
        isActive: json["isActive"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        token: json["token"] ?? '',
    );


}