class TherapistProfile {
  final String profilePicturePath;
  final String educationHistory;
  final int hourlyRate;
  final int experienceYears;
  final List<String> specializations;
  final String problemAreas;

  TherapistProfile({
    required this.profilePicturePath,
    required this.educationHistory,
    required this.hourlyRate,
    required this.experienceYears,
    required this.specializations,
    required this.problemAreas,
  });

  factory TherapistProfile.fromJson(Map<String, dynamic> json) {
    return TherapistProfile(
      profilePicturePath: json['profile_picture_path'],
      educationHistory: json['education_history'],
      hourlyRate: json['hourly_rate'],
      experienceYears: json['experience_years'],
      specializations: List<String>.from(json['specializations']),
      problemAreas: json['problem_areas'],
    );
  }
}