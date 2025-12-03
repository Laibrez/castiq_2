enum UserType { model, brandOwner }

class User {
  final String id;
  final String email;
  final String name;
  final UserType userType;
  final bool isVerified;
  final String? profileImage;
  final String? phone;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    this.isVerified = false,
    this.profileImage,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType.toString(),
      'isVerified': isVerified,
      'profileImage': profileImage,
      'phone': phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      userType: json['userType'] == 'UserType.model'
          ? UserType.model
          : UserType.brandOwner,
      isVerified: json['isVerified'] ?? false,
      profileImage: json['profileImage'],
      phone: json['phone'],
    );
  }
}
