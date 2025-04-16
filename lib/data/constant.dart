class AppConstants {
  static const String themeMode = 'themeMode';
}

enum UserRole {
  superAdmin,
  businessAdmin,
  businessUser,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.businessAdmin:
        return 'Business Admin';
      case UserRole.businessUser:
        return 'Business User';
      default:
        return toString().split('.').last; // Fallback to enum name
    }
  }
}