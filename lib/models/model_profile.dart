class ModelProfile {
  final String userId;
  final String bio;
  final double height;
  final String measurements;
  final List<String> skills;
  final List<String> languages;
  final String location;
  final bool isProfileBoosted;
  final DateTime? boostExpiryDate;

  ModelProfile({
    required this.userId,
    required this.bio,
    required this.height,
    required this.measurements,
    required this.skills,
    required this.languages,
    required this.location,
    this.isProfileBoosted = false,
    this.boostExpiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bio': bio,
      'height': height,
      'measurements': measurements,
      'skills': skills,
      'languages': languages,
      'location': location,
      'isProfileBoosted': isProfileBoosted,
      'boostExpiryDate': boostExpiryDate?.toIso8601String(),
    };
  }

  factory ModelProfile.fromJson(Map<String, dynamic> json) {
    return ModelProfile(
      userId: json['userId'],
      bio: json['bio'],
      height: json['height'],
      measurements: json['measurements'],
      skills: List<String>.from(json['skills']),
      languages: List<String>.from(json['languages']),
      location: json['location'],
      isProfileBoosted: json['isProfileBoosted'] ?? false,
      boostExpiryDate: json['boostExpiryDate'] != null
          ? DateTime.parse(json['boostExpiryDate'])
          : null,
    );
  }
}
