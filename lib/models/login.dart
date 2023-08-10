class Login {
  Login({
    this.token,
    this.message,
  });

  String? token;
  String? message;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
  };
}
