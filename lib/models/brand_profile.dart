class BrandProfile {
  final String userId;
  final String companyName;
  final String description;
  final String industry;
  final String location;
  final String? website;

  BrandProfile({
    required this.userId,
    required this.companyName,
    required this.description,
    required this.industry,
    required this.location,
    this.website,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'companyName': companyName,
      'description': description,
      'industry': industry,
      'location': location,
      'website': website,
    };
  }

  factory BrandProfile.fromJson(Map<String, dynamic> json) {
    return BrandProfile(
      userId: json['userId'],
      companyName: json['companyName'],
      description: json['description'],
      industry: json['industry'],
      location: json['location'],
      website: json['website'],
    );
  }
}
