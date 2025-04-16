import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String? username;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? password;
  final String? salt;
  final DateTime? lastLogin;
  final bool isSuperuser;
  final bool isStaff;
  final bool isActive;
  final DateTime? dateJoined;
  final String? phoneNumber;
  final bool isDeleted;

  const UserModel({
    required this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.password,
    this.salt,
    this.lastLogin,
    this.isSuperuser = false,
    this.isStaff = false,
    this.isActive = true,
    this.dateJoined,
    this.phoneNumber,
    this.isDeleted = false,
  });

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    String? password,
    String? salt,
    DateTime? lastLogin,
    bool? isSuperuser,
    bool? isStaff,
    bool? isActive,
    DateTime? dateJoined,
    String? phoneNumber,
    bool? isDeleted,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      password: password ?? this.password,
      salt: salt ?? this.salt,
      lastLogin: lastLogin ?? this.lastLogin,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      isStaff: isStaff ?? this.isStaff,
      isActive: isActive ?? this.isActive,
      dateJoined: dateJoined ?? this.dateJoined,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        firstname,
        lastname,
        password,
        salt,
        lastLogin,
        isSuperuser,
        isStaff,
        isActive,
        dateJoined,
        phoneNumber,
        isDeleted,
      ];
}

class RoleModel extends Equatable {
  final int id;
  final String name;

  const RoleModel({
    required this.id,
    required this.name,
  });

  RoleModel copyWith({
    int? id,
    String? name,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];
}

class UserRoleModel extends Equatable {
  final int id;
  final int userId;
  final int roleId;

  const UserRoleModel({
    required this.id,
    required this.userId,
    required this.roleId,

  });

  UserRoleModel copyWith({
    int? id,
    int? userId,
    int? roleId,
  }) {
    return UserRoleModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
    );
  }

  @override
  List<Object> get props => [id,userId, roleId];
}
class UserWithRolesModel {
  final String? username;
  final String? email;
  final String? firstname;
  final String? lastname;
  final DateTime? lastLogin;
  final bool isSuperuser;
  final bool isStaff;
  final bool isActive;
  final DateTime? dateJoined;
  final String? phoneNumber;
  final bool isDeleted;
  final int id;
  final List<RoleModel> roles;

  UserWithRolesModel({
    required this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.lastLogin,
    this.isSuperuser = false,
    this.isStaff = false,
    this.isActive = true,
    this.dateJoined,
    this.phoneNumber,
    this.isDeleted = false,
    required this.roles,
  });

  // Add the copyWith method
  UserWithRolesModel copyWith({
    int? id,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    DateTime? lastLogin,
    bool? isSuperuser,
    bool? isStaff,
    bool? isActive,
    DateTime? dateJoined,
    String? phoneNumber,
    bool? isDeleted,
    List<RoleModel>? roles,
  }) {
    return UserWithRolesModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      lastLogin: lastLogin ?? this.lastLogin,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      isStaff: isStaff ?? this.isStaff,
      isActive: isActive ?? this.isActive,
      dateJoined: dateJoined ?? this.dateJoined,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDeleted: isDeleted ?? this.isDeleted,
      roles: roles ?? this.roles,
    );
  }
}