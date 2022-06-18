import 'dart:convert';



UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userData,
    this.auth,
  });

  UserData userData;
  Auth auth;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData == null ? null : userData.toJson(),
        "auth": auth == null ? null : auth.toJson(),
      };
}

class Auth {
  Auth({
    this.accessToken,
    this.refreshToken,
  });

  String accessToken;
  String refreshToken;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken == null ? null : accessToken,
        "refreshToken": refreshToken == null ? null : refreshToken,
      };
}

class UserData {
  UserData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  
    this.gender,
    this.imageURL,
  });

  int userId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  String imageURL;
  int gender;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"] == null ? null : json["userId"],
        imageURL: json["imageUrl"] == null ? null : json["imageUrl"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
       
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
  
        "gender": gender == null ? null : gender,
        "imageUrl": imageURL == null ? null : imageURL,
      };
}
