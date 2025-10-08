class User {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String? profilePicture;
  final String? phoneNumber;
  final String? birthDate;
  final String? gender;
  final String? flyer;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    this.profilePicture,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.flyer,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      phoneNumber: json['phone_number'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      flyer: json['flyer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'email': email,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber,
      'birth_date': birthDate,
      'gender': gender,
      'flyer': flyer,
    };
  }
}