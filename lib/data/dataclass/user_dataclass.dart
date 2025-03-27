class UserDataClass {
  final int id;
  final String name;
  final String email;
  final DateTime? createdAt; // Make it nullable

  UserDataClass({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt, // No longer required
  });
}