
class LoginResponse {
  String? id;
  String? username;
  String? fullName;
  String? createdAt;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.fullName,
      this.createdAt,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  
}


class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
