class User {
  final int id;
  final String? username;
  final String fullName;
  final String email;
  final String? profilePicture;
  final String? phoneNumber;
  final String? birthDate;
  final String? gender;
  final String? flyer;
  final String role;

  User({
    required this.id,
    this.username,
    required this.fullName,
    required this.email,
    this.profilePicture,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.flyer,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String?,
      fullName: json['full_name'] as String? ?? 'Unknown User',
      email: json['email'] as String? ?? '',
      profilePicture: json['profile_picture'] as String?,
      phoneNumber: json['phone_number'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      flyer: json['flyer'] as String?,
      role: json['role'] as String? ?? 'klien',
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
      'role': role,
    };
  }
}