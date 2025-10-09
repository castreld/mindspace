import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/models/therapist_profile.dart';

class TherapistApplication {
  final User user;
  final TherapistProfile profile;

  TherapistApplication({required this.user, required this.profile});

  factory TherapistApplication.fromJson(Map<String, dynamic> json) {
    return TherapistApplication(
      user: User.fromJson(json),
      profile: TherapistProfile.fromJson(json['therapist_profile']),
    );
  }
}