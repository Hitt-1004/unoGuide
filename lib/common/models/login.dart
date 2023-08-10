class StudentLogin {
  StudentLogin({
    this.token,
    this.message,
  });

  String? token;
  String? message;

  factory StudentLogin.fromJson(Map<String, dynamic> json) => StudentLogin(
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
      };
}
