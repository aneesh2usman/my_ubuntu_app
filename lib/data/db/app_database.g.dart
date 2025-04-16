// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _firstnameMeta =
      const VerificationMeta('firstname');
  @override
  late final GeneratedColumn<String> firstname = GeneratedColumn<String>(
      'firstname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastnameMeta =
      const VerificationMeta('lastname');
  @override
  late final GeneratedColumn<String> lastname = GeneratedColumn<String>(
      'lastname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
      'salt', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastLoginMeta =
      const VerificationMeta('lastLogin');
  @override
  late final GeneratedColumn<DateTime> lastLogin = GeneratedColumn<DateTime>(
      'last_login', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isSuperuserMeta =
      const VerificationMeta('isSuperuser');
  @override
  late final GeneratedColumn<bool> isSuperuser = GeneratedColumn<bool>(
      'is_superuser', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_superuser" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isStaffMeta =
      const VerificationMeta('isStaff');
  @override
  late final GeneratedColumn<bool> isStaff = GeneratedColumn<bool>(
      'is_staff', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_staff" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dateJoinedMeta =
      const VerificationMeta('dateJoined');
  @override
  late final GeneratedColumn<DateTime> dateJoined = GeneratedColumn<DateTime>(
      'date_joined', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
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
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('firstname')) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableOrUnknown(data['firstname']!, _firstnameMeta));
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    }
    if (data.containsKey('last_login')) {
      context.handle(_lastLoginMeta,
          lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta));
    }
    if (data.containsKey('is_superuser')) {
      context.handle(
          _isSuperuserMeta,
          isSuperuser.isAcceptableOrUnknown(
              data['is_superuser']!, _isSuperuserMeta));
    }
    if (data.containsKey('is_staff')) {
      context.handle(_isStaffMeta,
          isStaff.isAcceptableOrUnknown(data['is_staff']!, _isStaffMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('date_joined')) {
      context.handle(
          _dateJoinedMeta,
          dateJoined.isAcceptableOrUnknown(
              data['date_joined']!, _dateJoinedMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      firstname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}firstname']),
      lastname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastname']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      salt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salt']),
      lastLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_login']),
      isSuperuser: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_superuser'])!,
      isStaff: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_staff'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      dateJoined: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_joined']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
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
  const UserTableData(
      {required this.id,
      this.username,
      this.email,
      this.firstname,
      this.lastname,
      this.password,
      this.salt,
      this.lastLogin,
      required this.isSuperuser,
      required this.isStaff,
      required this.isActive,
      this.dateJoined,
      this.phoneNumber,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || firstname != null) {
      map['firstname'] = Variable<String>(firstname);
    }
    if (!nullToAbsent || lastname != null) {
      map['lastname'] = Variable<String>(lastname);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || salt != null) {
      map['salt'] = Variable<String>(salt);
    }
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin);
    }
    map['is_superuser'] = Variable<bool>(isSuperuser);
    map['is_staff'] = Variable<bool>(isStaff);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || dateJoined != null) {
      map['date_joined'] = Variable<DateTime>(dateJoined);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      firstname: firstname == null && nullToAbsent
          ? const Value.absent()
          : Value(firstname),
      lastname: lastname == null && nullToAbsent
          ? const Value.absent()
          : Value(lastname),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      salt: salt == null && nullToAbsent ? const Value.absent() : Value(salt),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
      isSuperuser: Value(isSuperuser),
      isStaff: Value(isStaff),
      isActive: Value(isActive),
      dateJoined: dateJoined == null && nullToAbsent
          ? const Value.absent()
          : Value(dateJoined),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      isDeleted: Value(isDeleted),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      firstname: serializer.fromJson<String?>(json['firstname']),
      lastname: serializer.fromJson<String?>(json['lastname']),
      password: serializer.fromJson<String?>(json['password']),
      salt: serializer.fromJson<String?>(json['salt']),
      lastLogin: serializer.fromJson<DateTime?>(json['lastLogin']),
      isSuperuser: serializer.fromJson<bool>(json['isSuperuser']),
      isStaff: serializer.fromJson<bool>(json['isStaff']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      dateJoined: serializer.fromJson<DateTime?>(json['dateJoined']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String?>(username),
      'email': serializer.toJson<String?>(email),
      'firstname': serializer.toJson<String?>(firstname),
      'lastname': serializer.toJson<String?>(lastname),
      'password': serializer.toJson<String?>(password),
      'salt': serializer.toJson<String?>(salt),
      'lastLogin': serializer.toJson<DateTime?>(lastLogin),
      'isSuperuser': serializer.toJson<bool>(isSuperuser),
      'isStaff': serializer.toJson<bool>(isStaff),
      'isActive': serializer.toJson<bool>(isActive),
      'dateJoined': serializer.toJson<DateTime?>(dateJoined),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  UserTableData copyWith(
          {int? id,
          Value<String?> username = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> firstname = const Value.absent(),
          Value<String?> lastname = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> salt = const Value.absent(),
          Value<DateTime?> lastLogin = const Value.absent(),
          bool? isSuperuser,
          bool? isStaff,
          bool? isActive,
          Value<DateTime?> dateJoined = const Value.absent(),
          Value<String?> phoneNumber = const Value.absent(),
          bool? isDeleted}) =>
      UserTableData(
        id: id ?? this.id,
        username: username.present ? username.value : this.username,
        email: email.present ? email.value : this.email,
        firstname: firstname.present ? firstname.value : this.firstname,
        lastname: lastname.present ? lastname.value : this.lastname,
        password: password.present ? password.value : this.password,
        salt: salt.present ? salt.value : this.salt,
        lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
        isSuperuser: isSuperuser ?? this.isSuperuser,
        isStaff: isStaff ?? this.isStaff,
        isActive: isActive ?? this.isActive,
        dateJoined: dateJoined.present ? dateJoined.value : this.dateJoined,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      firstname: data.firstname.present ? data.firstname.value : this.firstname,
      lastname: data.lastname.present ? data.lastname.value : this.lastname,
      password: data.password.present ? data.password.value : this.password,
      salt: data.salt.present ? data.salt.value : this.salt,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
      isSuperuser:
          data.isSuperuser.present ? data.isSuperuser.value : this.isSuperuser,
      isStaff: data.isStaff.present ? data.isStaff.value : this.isStaff,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      dateJoined:
          data.dateJoined.present ? data.dateJoined.value : this.dateJoined,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('password: $password, ')
          ..write('salt: $salt, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('isSuperuser: $isSuperuser, ')
          ..write('isStaff: $isStaff, ')
          ..write('isActive: $isActive, ')
          ..write('dateJoined: $dateJoined, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.firstname == this.firstname &&
          other.lastname == this.lastname &&
          other.password == this.password &&
          other.salt == this.salt &&
          other.lastLogin == this.lastLogin &&
          other.isSuperuser == this.isSuperuser &&
          other.isStaff == this.isStaff &&
          other.isActive == this.isActive &&
          other.dateJoined == this.dateJoined &&
          other.phoneNumber == this.phoneNumber &&
          other.isDeleted == this.isDeleted);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<String?> username;
  final Value<String?> email;
  final Value<String?> firstname;
  final Value<String?> lastname;
  final Value<String?> password;
  final Value<String?> salt;
  final Value<DateTime?> lastLogin;
  final Value<bool> isSuperuser;
  final Value<bool> isStaff;
  final Value<bool> isActive;
  final Value<DateTime?> dateJoined;
  final Value<String?> phoneNumber;
  final Value<bool> isDeleted;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.password = const Value.absent(),
    this.salt = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.isSuperuser = const Value.absent(),
    this.isStaff = const Value.absent(),
    this.isActive = const Value.absent(),
    this.dateJoined = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.password = const Value.absent(),
    this.salt = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.isSuperuser = const Value.absent(),
    this.isStaff = const Value.absent(),
    this.isActive = const Value.absent(),
    this.dateJoined = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? firstname,
    Expression<String>? lastname,
    Expression<String>? password,
    Expression<String>? salt,
    Expression<DateTime>? lastLogin,
    Expression<bool>? isSuperuser,
    Expression<bool>? isStaff,
    Expression<bool>? isActive,
    Expression<DateTime>? dateJoined,
    Expression<String>? phoneNumber,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (firstname != null) 'firstname': firstname,
      if (lastname != null) 'lastname': lastname,
      if (password != null) 'password': password,
      if (salt != null) 'salt': salt,
      if (lastLogin != null) 'last_login': lastLogin,
      if (isSuperuser != null) 'is_superuser': isSuperuser,
      if (isStaff != null) 'is_staff': isStaff,
      if (isActive != null) 'is_active': isActive,
      if (dateJoined != null) 'date_joined': dateJoined,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? username,
      Value<String?>? email,
      Value<String?>? firstname,
      Value<String?>? lastname,
      Value<String?>? password,
      Value<String?>? salt,
      Value<DateTime?>? lastLogin,
      Value<bool>? isSuperuser,
      Value<bool>? isStaff,
      Value<bool>? isActive,
      Value<DateTime?>? dateJoined,
      Value<String?>? phoneNumber,
      Value<bool>? isDeleted}) {
    return UserTableCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (firstname.present) {
      map['firstname'] = Variable<String>(firstname.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime>(lastLogin.value);
    }
    if (isSuperuser.present) {
      map['is_superuser'] = Variable<bool>(isSuperuser.value);
    }
    if (isStaff.present) {
      map['is_staff'] = Variable<bool>(isStaff.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (dateJoined.present) {
      map['date_joined'] = Variable<DateTime>(dateJoined.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('password: $password, ')
          ..write('salt: $salt, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('isSuperuser: $isSuperuser, ')
          ..write('isStaff: $isStaff, ')
          ..write('isActive: $isActive, ')
          ..write('dateJoined: $dateJoined, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $RoleTableTable extends RoleTable
    with TableInfo<$RoleTableTable, RoleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'role_table';
  @override
  VerificationContext validateIntegrity(Insertable<RoleTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoleTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $RoleTableTable createAlias(String alias) {
    return $RoleTableTable(attachedDatabase, alias);
  }
}

class RoleTableData extends DataClass implements Insertable<RoleTableData> {
  final int id;
  final String name;
  const RoleTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  RoleTableCompanion toCompanion(bool nullToAbsent) {
    return RoleTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory RoleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoleTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  RoleTableData copyWith({int? id, String? name}) => RoleTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  RoleTableData copyWithCompanion(RoleTableCompanion data) {
    return RoleTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoleTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoleTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class RoleTableCompanion extends UpdateCompanion<RoleTableData> {
  final Value<int> id;
  final Value<String> name;
  const RoleTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  RoleTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<RoleTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  RoleTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return RoleTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoleTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $UserRoleTableTable extends UserRoleTable
    with TableInfo<$UserRoleTableTable, UserRoleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRoleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES user_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<int> roleId = GeneratedColumn<int>(
      'role_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES role_table (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, userId, roleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_role_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserRoleTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {userId, roleId},
      ];
  @override
  UserRoleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRoleTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_id'])!,
    );
  }

  @override
  $UserRoleTableTable createAlias(String alias) {
    return $UserRoleTableTable(attachedDatabase, alias);
  }
}

class UserRoleTableData extends DataClass
    implements Insertable<UserRoleTableData> {
  final int id;
  final int userId;
  final int roleId;
  const UserRoleTableData(
      {required this.id, required this.userId, required this.roleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['role_id'] = Variable<int>(roleId);
    return map;
  }

  UserRoleTableCompanion toCompanion(bool nullToAbsent) {
    return UserRoleTableCompanion(
      id: Value(id),
      userId: Value(userId),
      roleId: Value(roleId),
    );
  }

  factory UserRoleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRoleTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      roleId: serializer.fromJson<int>(json['roleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'roleId': serializer.toJson<int>(roleId),
    };
  }

  UserRoleTableData copyWith({int? id, int? userId, int? roleId}) =>
      UserRoleTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        roleId: roleId ?? this.roleId,
      );
  UserRoleTableData copyWithCompanion(UserRoleTableCompanion data) {
    return UserRoleTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRoleTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('roleId: $roleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, roleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRoleTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.roleId == this.roleId);
}

class UserRoleTableCompanion extends UpdateCompanion<UserRoleTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> roleId;
  const UserRoleTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.roleId = const Value.absent(),
  });
  UserRoleTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int roleId,
  })  : userId = Value(userId),
        roleId = Value(roleId);
  static Insertable<UserRoleTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? roleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (roleId != null) 'role_id': roleId,
    });
  }

  UserRoleTableCompanion copyWith(
      {Value<int>? id, Value<int>? userId, Value<int>? roleId}) {
    return UserRoleTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<int>(roleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRoleTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('roleId: $roleId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $RoleTableTable roleTable = $RoleTableTable(this);
  late final $UserRoleTableTable userRoleTable = $UserRoleTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userTable, roleTable, userRoleTable];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('user_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('user_role_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('role_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('user_role_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> email,
  Value<String?> firstname,
  Value<String?> lastname,
  Value<String?> password,
  Value<String?> salt,
  Value<DateTime?> lastLogin,
  Value<bool> isSuperuser,
  Value<bool> isStaff,
  Value<bool> isActive,
  Value<DateTime?> dateJoined,
  Value<String?> phoneNumber,
  Value<bool> isDeleted,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> email,
  Value<String?> firstname,
  Value<String?> lastname,
  Value<String?> password,
  Value<String?> salt,
  Value<DateTime?> lastLogin,
  Value<bool> isSuperuser,
  Value<bool> isStaff,
  Value<bool> isActive,
  Value<DateTime?> dateJoined,
  Value<String?> phoneNumber,
  Value<bool> isDeleted,
});

final class $$UserTableTableReferences
    extends BaseReferences<_$AppDatabase, $UserTableTable, UserTableData> {
  $$UserTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserRoleTableTable, List<UserRoleTableData>>
      _userRoleTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userRoleTable,
              aliasName: $_aliasNameGenerator(
                  db.userTable.id, db.userRoleTable.userId));

  $$UserRoleTableTableProcessedTableManager get userRoleTableRefs {
    final manager = $$UserRoleTableTableTableManager($_db, $_db.userRoleTable)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userRoleTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstname => $composableBuilder(
      column: $table.firstname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastname => $composableBuilder(
      column: $table.lastname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSuperuser => $composableBuilder(
      column: $table.isSuperuser, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isStaff => $composableBuilder(
      column: $table.isStaff, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  Expression<bool> userRoleTableRefs(
      Expression<bool> Function($$UserRoleTableTableFilterComposer f) f) {
    final $$UserRoleTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userRoleTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserRoleTableTableFilterComposer(
              $db: $db,
              $table: $db.userRoleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstname => $composableBuilder(
      column: $table.firstname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastname => $composableBuilder(
      column: $table.lastname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSuperuser => $composableBuilder(
      column: $table.isSuperuser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isStaff => $composableBuilder(
      column: $table.isStaff, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get firstname =>
      $composableBuilder(column: $table.firstname, builder: (column) => column);

  GeneratedColumn<String> get lastname =>
      $composableBuilder(column: $table.lastname, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);

  GeneratedColumn<bool> get isSuperuser => $composableBuilder(
      column: $table.isSuperuser, builder: (column) => column);

  GeneratedColumn<bool> get isStaff =>
      $composableBuilder(column: $table.isStaff, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> userRoleTableRefs<T extends Object>(
      Expression<T> Function($$UserRoleTableTableAnnotationComposer a) f) {
    final $$UserRoleTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userRoleTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserRoleTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userRoleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (UserTableData, $$UserTableTableReferences),
    UserTableData,
    PrefetchHooks Function({bool userRoleTableRefs})> {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> firstname = const Value.absent(),
            Value<String?> lastname = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> salt = const Value.absent(),
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<bool> isSuperuser = const Value.absent(),
            Value<bool> isStaff = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> dateJoined = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            username: username,
            email: email,
            firstname: firstname,
            lastname: lastname,
            password: password,
            salt: salt,
            lastLogin: lastLogin,
            isSuperuser: isSuperuser,
            isStaff: isStaff,
            isActive: isActive,
            dateJoined: dateJoined,
            phoneNumber: phoneNumber,
            isDeleted: isDeleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> firstname = const Value.absent(),
            Value<String?> lastname = const Value.absent(),
            Value<String?> password = const Value.absent(),
            Value<String?> salt = const Value.absent(),
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<bool> isSuperuser = const Value.absent(),
            Value<bool> isStaff = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> dateJoined = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            username: username,
            email: email,
            firstname: firstname,
            lastname: lastname,
            password: password,
            salt: salt,
            lastLogin: lastLogin,
            isSuperuser: isSuperuser,
            isStaff: isStaff,
            isActive: isActive,
            dateJoined: dateJoined,
            phoneNumber: phoneNumber,
            isDeleted: isDeleted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userRoleTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userRoleTableRefs) db.userRoleTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userRoleTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            UserRoleTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._userRoleTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .userRoleTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (UserTableData, $$UserTableTableReferences),
    UserTableData,
    PrefetchHooks Function({bool userRoleTableRefs})>;
typedef $$RoleTableTableCreateCompanionBuilder = RoleTableCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$RoleTableTableUpdateCompanionBuilder = RoleTableCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$RoleTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoleTableTable, RoleTableData> {
  $$RoleTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserRoleTableTable, List<UserRoleTableData>>
      _userRoleTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userRoleTable,
              aliasName: $_aliasNameGenerator(
                  db.roleTable.id, db.userRoleTable.roleId));

  $$UserRoleTableTableProcessedTableManager get userRoleTableRefs {
    final manager = $$UserRoleTableTableTableManager($_db, $_db.userRoleTable)
        .filter((f) => f.roleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userRoleTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RoleTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> userRoleTableRefs(
      Expression<bool> Function($$UserRoleTableTableFilterComposer f) f) {
    final $$UserRoleTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userRoleTable,
        getReferencedColumn: (t) => t.roleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserRoleTableTableFilterComposer(
              $db: $db,
              $table: $db.userRoleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$RoleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoleTableTable> {
  $$RoleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> userRoleTableRefs<T extends Object>(
      Expression<T> Function($$UserRoleTableTableAnnotationComposer a) f) {
    final $$UserRoleTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userRoleTable,
        getReferencedColumn: (t) => t.roleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserRoleTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userRoleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RoleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoleTableTable,
    RoleTableData,
    $$RoleTableTableFilterComposer,
    $$RoleTableTableOrderingComposer,
    $$RoleTableTableAnnotationComposer,
    $$RoleTableTableCreateCompanionBuilder,
    $$RoleTableTableUpdateCompanionBuilder,
    (RoleTableData, $$RoleTableTableReferences),
    RoleTableData,
    PrefetchHooks Function({bool userRoleTableRefs})> {
  $$RoleTableTableTableManager(_$AppDatabase db, $RoleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              RoleTableCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              RoleTableCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RoleTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userRoleTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userRoleTableRefs) db.userRoleTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userRoleTableRefs)
                    await $_getPrefetchedData<RoleTableData, $RoleTableTable,
                            UserRoleTableData>(
                        currentTable: table,
                        referencedTable: $$RoleTableTableReferences
                            ._userRoleTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RoleTableTableReferences(db, table, p0)
                                .userRoleTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RoleTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoleTableTable,
    RoleTableData,
    $$RoleTableTableFilterComposer,
    $$RoleTableTableOrderingComposer,
    $$RoleTableTableAnnotationComposer,
    $$RoleTableTableCreateCompanionBuilder,
    $$RoleTableTableUpdateCompanionBuilder,
    (RoleTableData, $$RoleTableTableReferences),
    RoleTableData,
    PrefetchHooks Function({bool userRoleTableRefs})>;
typedef $$UserRoleTableTableCreateCompanionBuilder = UserRoleTableCompanion
    Function({
  Value<int> id,
  required int userId,
  required int roleId,
});
typedef $$UserRoleTableTableUpdateCompanionBuilder = UserRoleTableCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<int> roleId,
});

final class $$UserRoleTableTableReferences extends BaseReferences<_$AppDatabase,
    $UserRoleTableTable, UserRoleTableData> {
  $$UserRoleTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UserTableTable _userIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.userRoleTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RoleTableTable _roleIdTable(_$AppDatabase db) =>
      db.roleTable.createAlias(
          $_aliasNameGenerator(db.userRoleTable.roleId, db.roleTable.id));

  $$RoleTableTableProcessedTableManager get roleId {
    final $_column = $_itemColumn<int>('role_id')!;

    final manager = $$RoleTableTableTableManager($_db, $_db.roleTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserRoleTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRoleTableTable> {
  $$UserRoleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoleTableTableFilterComposer get roleId {
    final $$RoleTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roleTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoleTableTableFilterComposer(
              $db: $db,
              $table: $db.roleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserRoleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRoleTableTable> {
  $$UserRoleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoleTableTableOrderingComposer get roleId {
    final $$RoleTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roleTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoleTableTableOrderingComposer(
              $db: $db,
              $table: $db.roleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserRoleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRoleTableTable> {
  $$UserRoleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RoleTableTableAnnotationComposer get roleId {
    final $$RoleTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roleTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RoleTableTableAnnotationComposer(
              $db: $db,
              $table: $db.roleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserRoleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserRoleTableTable,
    UserRoleTableData,
    $$UserRoleTableTableFilterComposer,
    $$UserRoleTableTableOrderingComposer,
    $$UserRoleTableTableAnnotationComposer,
    $$UserRoleTableTableCreateCompanionBuilder,
    $$UserRoleTableTableUpdateCompanionBuilder,
    (UserRoleTableData, $$UserRoleTableTableReferences),
    UserRoleTableData,
    PrefetchHooks Function({bool userId, bool roleId})> {
  $$UserRoleTableTableTableManager(_$AppDatabase db, $UserRoleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRoleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRoleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRoleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> roleId = const Value.absent(),
          }) =>
              UserRoleTableCompanion(
            id: id,
            userId: userId,
            roleId: roleId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required int roleId,
          }) =>
              UserRoleTableCompanion.insert(
            id: id,
            userId: userId,
            roleId: roleId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserRoleTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false, roleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserRoleTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserRoleTableTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (roleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roleId,
                    referencedTable:
                        $$UserRoleTableTableReferences._roleIdTable(db),
                    referencedColumn:
                        $$UserRoleTableTableReferences._roleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserRoleTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserRoleTableTable,
    UserRoleTableData,
    $$UserRoleTableTableFilterComposer,
    $$UserRoleTableTableOrderingComposer,
    $$UserRoleTableTableAnnotationComposer,
    $$UserRoleTableTableCreateCompanionBuilder,
    $$UserRoleTableTableUpdateCompanionBuilder,
    (UserRoleTableData, $$UserRoleTableTableReferences),
    UserRoleTableData,
    PrefetchHooks Function({bool userId, bool roleId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$RoleTableTableTableManager get roleTable =>
      $$RoleTableTableTableManager(_db, _db.roleTable);
  $$UserRoleTableTableTableManager get userRoleTable =>
      $$UserRoleTableTableTableManager(_db, _db.userRoleTable);
}
