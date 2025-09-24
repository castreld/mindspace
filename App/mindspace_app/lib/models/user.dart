class User {
  final String username;
  final String email;

  User({required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? 'No Username',
      email: json['email'] ?? 'No Email',
    );
  }
}