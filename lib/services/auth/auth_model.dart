class UserLogin {
  final String email;
  final String name;
  final String token;

  UserLogin({
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'token': token,
    };
  }
}

class UserReg {
  final String name;
  final String email;

  UserReg({required this.name, required this.email});

  factory UserReg.fromJson(Map<String, dynamic> json) {
    return UserReg(
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}
