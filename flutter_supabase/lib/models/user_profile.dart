class UserProfile {
  final String id;
  final String email;

  UserProfile({required this.id, required this.email});

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      email: map['email'],
    );
  }
}
