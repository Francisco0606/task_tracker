class User {
  final int? user_id;
  final String name;
  final String username;
  final String password;
  final String email;

  User(
      {this.user_id,
      required this.name,
      required this.username,
      required this.password,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'name': name,
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
    );
  }
}
