// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 5, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
      'salt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _biometricEnabledMeta =
      const VerificationMeta('biometricEnabled');
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
      'biometric_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometric_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sessionTokenMeta =
      const VerificationMeta('sessionToken');
  @override
  late final GeneratedColumn<String> sessionToken = GeneratedColumn<String>(
      'session_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sessionExpiryMeta =
      const VerificationMeta('sessionExpiry');
  @override
  late final GeneratedColumn<DateTime> sessionExpiry =
      GeneratedColumn<DateTime>('session_expiry', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        email,
        passwordHash,
        salt,
        fullName,
        phone,
        photoPath,
        biometricEnabled,
        sessionToken,
        sessionExpiry,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
          _biometricEnabledMeta,
          biometricEnabled.isAcceptableOrUnknown(
              data['biometric_enabled']!, _biometricEnabledMeta));
    }
    if (data.containsKey('session_token')) {
      context.handle(
          _sessionTokenMeta,
          sessionToken.isAcceptableOrUnknown(
              data['session_token']!, _sessionTokenMeta));
    }
    if (data.containsKey('session_expiry')) {
      context.handle(
          _sessionExpiryMeta,
          sessionExpiry.isAcceptableOrUnknown(
              data['session_expiry']!, _sessionExpiryMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      salt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salt'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      biometricEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}biometric_enabled'])!,
      sessionToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_token']),
      sessionExpiry: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}session_expiry']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String email;
  final String passwordHash;
  final String salt;
  final String? fullName;
  final String? phone;
  final String? photoPath;
  final bool biometricEnabled;
  final String? sessionToken;
  final DateTime? sessionExpiry;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User(
      {required this.id,
      required this.username,
      required this.email,
      required this.passwordHash,
      required this.salt,
      this.fullName,
      this.phone,
      this.photoPath,
      required this.biometricEnabled,
      this.sessionToken,
      this.sessionExpiry,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['salt'] = Variable<String>(salt);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    if (!nullToAbsent || sessionToken != null) {
      map['session_token'] = Variable<String>(sessionToken);
    }
    if (!nullToAbsent || sessionExpiry != null) {
      map['session_expiry'] = Variable<DateTime>(sessionExpiry);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      passwordHash: Value(passwordHash),
      salt: Value(salt),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      biometricEnabled: Value(biometricEnabled),
      sessionToken: sessionToken == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionToken),
      sessionExpiry: sessionExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionExpiry),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      salt: serializer.fromJson<String>(json['salt']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      sessionToken: serializer.fromJson<String?>(json['sessionToken']),
      sessionExpiry: serializer.fromJson<DateTime?>(json['sessionExpiry']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'salt': serializer.toJson<String>(salt),
      'fullName': serializer.toJson<String?>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'photoPath': serializer.toJson<String?>(photoPath),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'sessionToken': serializer.toJson<String?>(sessionToken),
      'sessionExpiry': serializer.toJson<DateTime?>(sessionExpiry),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? email,
          String? passwordHash,
          String? salt,
          Value<String?> fullName = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          bool? biometricEnabled,
          Value<String?> sessionToken = const Value.absent(),
          Value<DateTime?> sessionExpiry = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        salt: salt ?? this.salt,
        fullName: fullName.present ? fullName.value : this.fullName,
        phone: phone.present ? phone.value : this.phone,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
        sessionToken:
            sessionToken.present ? sessionToken.value : this.sessionToken,
        sessionExpiry:
            sessionExpiry.present ? sessionExpiry.value : this.sessionExpiry,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      salt: data.salt.present ? data.salt.value : this.salt,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      biometricEnabled: data.biometricEnabled.present
          ? data.biometricEnabled.value
          : this.biometricEnabled,
      sessionToken: data.sessionToken.present
          ? data.sessionToken.value
          : this.sessionToken,
      sessionExpiry: data.sessionExpiry.present
          ? data.sessionExpiry.value
          : this.sessionExpiry,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('sessionToken: $sessionToken, ')
          ..write('sessionExpiry: $sessionExpiry, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      email,
      passwordHash,
      salt,
      fullName,
      phone,
      photoPath,
      biometricEnabled,
      sessionToken,
      sessionExpiry,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.photoPath == this.photoPath &&
          other.biometricEnabled == this.biometricEnabled &&
          other.sessionToken == this.sessionToken &&
          other.sessionExpiry == this.sessionExpiry &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> salt;
  final Value<String?> fullName;
  final Value<String?> phone;
  final Value<String?> photoPath;
  final Value<bool> biometricEnabled;
  final Value<String?> sessionToken;
  final Value<DateTime?> sessionExpiry;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.sessionToken = const Value.absent(),
    this.sessionExpiry = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String passwordHash,
    required String salt,
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.sessionToken = const Value.absent(),
    this.sessionExpiry = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : username = Value(username),
        email = Value(email),
        passwordHash = Value(passwordHash),
        salt = Value(salt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? salt,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? photoPath,
    Expression<bool>? biometricEnabled,
    Expression<String>? sessionToken,
    Expression<DateTime>? sessionExpiry,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (photoPath != null) 'photo_path': photoPath,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (sessionToken != null) 'session_token': sessionToken,
      if (sessionExpiry != null) 'session_expiry': sessionExpiry,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<String>? salt,
      Value<String?>? fullName,
      Value<String?>? phone,
      Value<String?>? photoPath,
      Value<bool>? biometricEnabled,
      Value<String?>? sessionToken,
      Value<DateTime?>? sessionExpiry,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      sessionToken: sessionToken ?? this.sessionToken,
      sessionExpiry: sessionExpiry ?? this.sessionExpiry,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (sessionToken.present) {
      map['session_token'] = Variable<String>(sessionToken.value);
    }
    if (sessionExpiry.present) {
      map['session_expiry'] = Variable<DateTime>(sessionExpiry.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('sessionToken: $sessionToken, ')
          ..write('sessionExpiry: $sessionExpiry, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _destinationMeta =
      const VerificationMeta('destination');
  @override
  late final GeneratedColumn<String> destination = GeneratedColumn<String>(
      'destination', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routeJsonMeta =
      const VerificationMeta('routeJson');
  @override
  late final GeneratedColumn<String> routeJson = GeneratedColumn<String>(
      'route_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transportModesMeta =
      const VerificationMeta('transportModes');
  @override
  late final GeneratedColumn<String> transportModes = GeneratedColumn<String>(
      'transport_modes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _crowdScoreMeta =
      const VerificationMeta('crowdScore');
  @override
  late final GeneratedColumn<double> crowdScore = GeneratedColumn<double>(
      'crowd_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estimatedMinutesMeta =
      const VerificationMeta('estimatedMinutes');
  @override
  late final GeneratedColumn<double> estimatedMinutes = GeneratedColumn<double>(
      'estimated_minutes', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fareIdrMeta =
      const VerificationMeta('fareIdr');
  @override
  late final GeneratedColumn<double> fareIdr = GeneratedColumn<double>(
      'fare_idr', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _tripDateMeta =
      const VerificationMeta('tripDate');
  @override
  late final GeneratedColumn<DateTime> tripDate = GeneratedColumn<DateTime>(
      'trip_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        origin,
        destination,
        routeJson,
        transportModes,
        crowdScore,
        estimatedMinutes,
        fareIdr,
        tripDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(Insertable<Trip> instance,
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
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
          _destinationMeta,
          destination.isAcceptableOrUnknown(
              data['destination']!, _destinationMeta));
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('route_json')) {
      context.handle(_routeJsonMeta,
          routeJson.isAcceptableOrUnknown(data['route_json']!, _routeJsonMeta));
    } else if (isInserting) {
      context.missing(_routeJsonMeta);
    }
    if (data.containsKey('transport_modes')) {
      context.handle(
          _transportModesMeta,
          transportModes.isAcceptableOrUnknown(
              data['transport_modes']!, _transportModesMeta));
    } else if (isInserting) {
      context.missing(_transportModesMeta);
    }
    if (data.containsKey('crowd_score')) {
      context.handle(
          _crowdScoreMeta,
          crowdScore.isAcceptableOrUnknown(
              data['crowd_score']!, _crowdScoreMeta));
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
          _estimatedMinutesMeta,
          estimatedMinutes.isAcceptableOrUnknown(
              data['estimated_minutes']!, _estimatedMinutesMeta));
    }
    if (data.containsKey('fare_idr')) {
      context.handle(_fareIdrMeta,
          fareIdr.isAcceptableOrUnknown(data['fare_idr']!, _fareIdrMeta));
    }
    if (data.containsKey('trip_date')) {
      context.handle(_tripDateMeta,
          tripDate.isAcceptableOrUnknown(data['trip_date']!, _tripDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      destination: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}destination'])!,
      routeJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}route_json'])!,
      transportModes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transport_modes'])!,
      crowdScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}crowd_score']),
      estimatedMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}estimated_minutes']),
      fareIdr: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fare_idr']),
      tripDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}trip_date'])!,
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends DataClass implements Insertable<Trip> {
  final int id;
  final int userId;
  final String origin;
  final String destination;
  final String routeJson;
  final String transportModes;
  final double? crowdScore;
  final double? estimatedMinutes;
  final double? fareIdr;
  final DateTime tripDate;
  const Trip(
      {required this.id,
      required this.userId,
      required this.origin,
      required this.destination,
      required this.routeJson,
      required this.transportModes,
      this.crowdScore,
      this.estimatedMinutes,
      this.fareIdr,
      required this.tripDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['origin'] = Variable<String>(origin);
    map['destination'] = Variable<String>(destination);
    map['route_json'] = Variable<String>(routeJson);
    map['transport_modes'] = Variable<String>(transportModes);
    if (!nullToAbsent || crowdScore != null) {
      map['crowd_score'] = Variable<double>(crowdScore);
    }
    if (!nullToAbsent || estimatedMinutes != null) {
      map['estimated_minutes'] = Variable<double>(estimatedMinutes);
    }
    if (!nullToAbsent || fareIdr != null) {
      map['fare_idr'] = Variable<double>(fareIdr);
    }
    map['trip_date'] = Variable<DateTime>(tripDate);
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      userId: Value(userId),
      origin: Value(origin),
      destination: Value(destination),
      routeJson: Value(routeJson),
      transportModes: Value(transportModes),
      crowdScore: crowdScore == null && nullToAbsent
          ? const Value.absent()
          : Value(crowdScore),
      estimatedMinutes: estimatedMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedMinutes),
      fareIdr: fareIdr == null && nullToAbsent
          ? const Value.absent()
          : Value(fareIdr),
      tripDate: Value(tripDate),
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      origin: serializer.fromJson<String>(json['origin']),
      destination: serializer.fromJson<String>(json['destination']),
      routeJson: serializer.fromJson<String>(json['routeJson']),
      transportModes: serializer.fromJson<String>(json['transportModes']),
      crowdScore: serializer.fromJson<double?>(json['crowdScore']),
      estimatedMinutes: serializer.fromJson<double?>(json['estimatedMinutes']),
      fareIdr: serializer.fromJson<double?>(json['fareIdr']),
      tripDate: serializer.fromJson<DateTime>(json['tripDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'origin': serializer.toJson<String>(origin),
      'destination': serializer.toJson<String>(destination),
      'routeJson': serializer.toJson<String>(routeJson),
      'transportModes': serializer.toJson<String>(transportModes),
      'crowdScore': serializer.toJson<double?>(crowdScore),
      'estimatedMinutes': serializer.toJson<double?>(estimatedMinutes),
      'fareIdr': serializer.toJson<double?>(fareIdr),
      'tripDate': serializer.toJson<DateTime>(tripDate),
    };
  }

  Trip copyWith(
          {int? id,
          int? userId,
          String? origin,
          String? destination,
          String? routeJson,
          String? transportModes,
          Value<double?> crowdScore = const Value.absent(),
          Value<double?> estimatedMinutes = const Value.absent(),
          Value<double?> fareIdr = const Value.absent(),
          DateTime? tripDate}) =>
      Trip(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        routeJson: routeJson ?? this.routeJson,
        transportModes: transportModes ?? this.transportModes,
        crowdScore: crowdScore.present ? crowdScore.value : this.crowdScore,
        estimatedMinutes: estimatedMinutes.present
            ? estimatedMinutes.value
            : this.estimatedMinutes,
        fareIdr: fareIdr.present ? fareIdr.value : this.fareIdr,
        tripDate: tripDate ?? this.tripDate,
      );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      origin: data.origin.present ? data.origin.value : this.origin,
      destination:
          data.destination.present ? data.destination.value : this.destination,
      routeJson: data.routeJson.present ? data.routeJson.value : this.routeJson,
      transportModes: data.transportModes.present
          ? data.transportModes.value
          : this.transportModes,
      crowdScore:
          data.crowdScore.present ? data.crowdScore.value : this.crowdScore,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      fareIdr: data.fareIdr.present ? data.fareIdr.value : this.fareIdr,
      tripDate: data.tripDate.present ? data.tripDate.value : this.tripDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('routeJson: $routeJson, ')
          ..write('transportModes: $transportModes, ')
          ..write('crowdScore: $crowdScore, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('fareIdr: $fareIdr, ')
          ..write('tripDate: $tripDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, origin, destination, routeJson,
      transportModes, crowdScore, estimatedMinutes, fareIdr, tripDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.origin == this.origin &&
          other.destination == this.destination &&
          other.routeJson == this.routeJson &&
          other.transportModes == this.transportModes &&
          other.crowdScore == this.crowdScore &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.fareIdr == this.fareIdr &&
          other.tripDate == this.tripDate);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> origin;
  final Value<String> destination;
  final Value<String> routeJson;
  final Value<String> transportModes;
  final Value<double?> crowdScore;
  final Value<double?> estimatedMinutes;
  final Value<double?> fareIdr;
  final Value<DateTime> tripDate;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.origin = const Value.absent(),
    this.destination = const Value.absent(),
    this.routeJson = const Value.absent(),
    this.transportModes = const Value.absent(),
    this.crowdScore = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.fareIdr = const Value.absent(),
    this.tripDate = const Value.absent(),
  });
  TripsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String origin,
    required String destination,
    required String routeJson,
    required String transportModes,
    this.crowdScore = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.fareIdr = const Value.absent(),
    this.tripDate = const Value.absent(),
  })  : userId = Value(userId),
        origin = Value(origin),
        destination = Value(destination),
        routeJson = Value(routeJson),
        transportModes = Value(transportModes);
  static Insertable<Trip> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? origin,
    Expression<String>? destination,
    Expression<String>? routeJson,
    Expression<String>? transportModes,
    Expression<double>? crowdScore,
    Expression<double>? estimatedMinutes,
    Expression<double>? fareIdr,
    Expression<DateTime>? tripDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (origin != null) 'origin': origin,
      if (destination != null) 'destination': destination,
      if (routeJson != null) 'route_json': routeJson,
      if (transportModes != null) 'transport_modes': transportModes,
      if (crowdScore != null) 'crowd_score': crowdScore,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (fareIdr != null) 'fare_idr': fareIdr,
      if (tripDate != null) 'trip_date': tripDate,
    });
  }

  TripsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? origin,
      Value<String>? destination,
      Value<String>? routeJson,
      Value<String>? transportModes,
      Value<double?>? crowdScore,
      Value<double?>? estimatedMinutes,
      Value<double?>? fareIdr,
      Value<DateTime>? tripDate}) {
    return TripsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      routeJson: routeJson ?? this.routeJson,
      transportModes: transportModes ?? this.transportModes,
      crowdScore: crowdScore ?? this.crowdScore,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      fareIdr: fareIdr ?? this.fareIdr,
      tripDate: tripDate ?? this.tripDate,
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
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (routeJson.present) {
      map['route_json'] = Variable<String>(routeJson.value);
    }
    if (transportModes.present) {
      map['transport_modes'] = Variable<String>(transportModes.value);
    }
    if (crowdScore.present) {
      map['crowd_score'] = Variable<double>(crowdScore.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<double>(estimatedMinutes.value);
    }
    if (fareIdr.present) {
      map['fare_idr'] = Variable<double>(fareIdr.value);
    }
    if (tripDate.present) {
      map['trip_date'] = Variable<DateTime>(tripDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('routeJson: $routeJson, ')
          ..write('transportModes: $transportModes, ')
          ..write('crowdScore: $crowdScore, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('fareIdr: $fareIdr, ')
          ..write('tripDate: $tripDate')
          ..write(')'))
        .toString();
  }
}

class $CrowdReportsTable extends CrowdReports
    with TableInfo<$CrowdReportsTable, CrowdReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrowdReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _stationIdMeta =
      const VerificationMeta('stationId');
  @override
  late final GeneratedColumn<String> stationId = GeneratedColumn<String>(
      'station_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stationNameMeta =
      const VerificationMeta('stationName');
  @override
  late final GeneratedColumn<String> stationName = GeneratedColumn<String>(
      'station_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reporterIdMeta =
      const VerificationMeta('reporterId');
  @override
  late final GeneratedColumn<int> reporterId = GeneratedColumn<int>(
      'reporter_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _transportTypeMeta =
      const VerificationMeta('transportType');
  @override
  late final GeneratedColumn<String> transportType = GeneratedColumn<String>(
      'transport_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reportedAtMeta =
      const VerificationMeta('reportedAt');
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
      'reported_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        stationId,
        stationName,
        level,
        reporterId,
        transportType,
        direction,
        reportedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crowd_reports';
  @override
  VerificationContext validateIntegrity(Insertable<CrowdReport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(_stationIdMeta,
          stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta));
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('station_name')) {
      context.handle(
          _stationNameMeta,
          stationName.isAcceptableOrUnknown(
              data['station_name']!, _stationNameMeta));
    } else if (isInserting) {
      context.missing(_stationNameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('reporter_id')) {
      context.handle(
          _reporterIdMeta,
          reporterId.isAcceptableOrUnknown(
              data['reporter_id']!, _reporterIdMeta));
    } else if (isInserting) {
      context.missing(_reporterIdMeta);
    }
    if (data.containsKey('transport_type')) {
      context.handle(
          _transportTypeMeta,
          transportType.isAcceptableOrUnknown(
              data['transport_type']!, _transportTypeMeta));
    } else if (isInserting) {
      context.missing(_transportTypeMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    }
    if (data.containsKey('reported_at')) {
      context.handle(
          _reportedAtMeta,
          reportedAt.isAcceptableOrUnknown(
              data['reported_at']!, _reportedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrowdReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrowdReport(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      stationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}station_id'])!,
      stationName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}station_name'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      reporterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reporter_id'])!,
      transportType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transport_type'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction']),
      reportedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reported_at'])!,
    );
  }

  @override
  $CrowdReportsTable createAlias(String alias) {
    return $CrowdReportsTable(attachedDatabase, alias);
  }
}

class CrowdReport extends DataClass implements Insertable<CrowdReport> {
  final int id;
  final String stationId;
  final String stationName;
  final int level;
  final int reporterId;
  final String transportType;
  final String? direction;
  final DateTime reportedAt;
  const CrowdReport(
      {required this.id,
      required this.stationId,
      required this.stationName,
      required this.level,
      required this.reporterId,
      required this.transportType,
      this.direction,
      required this.reportedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<String>(stationId);
    map['station_name'] = Variable<String>(stationName);
    map['level'] = Variable<int>(level);
    map['reporter_id'] = Variable<int>(reporterId);
    map['transport_type'] = Variable<String>(transportType);
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<String>(direction);
    }
    map['reported_at'] = Variable<DateTime>(reportedAt);
    return map;
  }

  CrowdReportsCompanion toCompanion(bool nullToAbsent) {
    return CrowdReportsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      stationName: Value(stationName),
      level: Value(level),
      reporterId: Value(reporterId),
      transportType: Value(transportType),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      reportedAt: Value(reportedAt),
    );
  }

  factory CrowdReport.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrowdReport(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<String>(json['stationId']),
      stationName: serializer.fromJson<String>(json['stationName']),
      level: serializer.fromJson<int>(json['level']),
      reporterId: serializer.fromJson<int>(json['reporterId']),
      transportType: serializer.fromJson<String>(json['transportType']),
      direction: serializer.fromJson<String?>(json['direction']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<String>(stationId),
      'stationName': serializer.toJson<String>(stationName),
      'level': serializer.toJson<int>(level),
      'reporterId': serializer.toJson<int>(reporterId),
      'transportType': serializer.toJson<String>(transportType),
      'direction': serializer.toJson<String?>(direction),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
    };
  }

  CrowdReport copyWith(
          {int? id,
          String? stationId,
          String? stationName,
          int? level,
          int? reporterId,
          String? transportType,
          Value<String?> direction = const Value.absent(),
          DateTime? reportedAt}) =>
      CrowdReport(
        id: id ?? this.id,
        stationId: stationId ?? this.stationId,
        stationName: stationName ?? this.stationName,
        level: level ?? this.level,
        reporterId: reporterId ?? this.reporterId,
        transportType: transportType ?? this.transportType,
        direction: direction.present ? direction.value : this.direction,
        reportedAt: reportedAt ?? this.reportedAt,
      );
  CrowdReport copyWithCompanion(CrowdReportsCompanion data) {
    return CrowdReport(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      stationName:
          data.stationName.present ? data.stationName.value : this.stationName,
      level: data.level.present ? data.level.value : this.level,
      reporterId:
          data.reporterId.present ? data.reporterId.value : this.reporterId,
      transportType: data.transportType.present
          ? data.transportType.value
          : this.transportType,
      direction: data.direction.present ? data.direction.value : this.direction,
      reportedAt:
          data.reportedAt.present ? data.reportedAt.value : this.reportedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrowdReport(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('stationName: $stationName, ')
          ..write('level: $level, ')
          ..write('reporterId: $reporterId, ')
          ..write('transportType: $transportType, ')
          ..write('direction: $direction, ')
          ..write('reportedAt: $reportedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stationId, stationName, level, reporterId,
      transportType, direction, reportedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrowdReport &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.stationName == this.stationName &&
          other.level == this.level &&
          other.reporterId == this.reporterId &&
          other.transportType == this.transportType &&
          other.direction == this.direction &&
          other.reportedAt == this.reportedAt);
}

class CrowdReportsCompanion extends UpdateCompanion<CrowdReport> {
  final Value<int> id;
  final Value<String> stationId;
  final Value<String> stationName;
  final Value<int> level;
  final Value<int> reporterId;
  final Value<String> transportType;
  final Value<String?> direction;
  final Value<DateTime> reportedAt;
  const CrowdReportsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.stationName = const Value.absent(),
    this.level = const Value.absent(),
    this.reporterId = const Value.absent(),
    this.transportType = const Value.absent(),
    this.direction = const Value.absent(),
    this.reportedAt = const Value.absent(),
  });
  CrowdReportsCompanion.insert({
    this.id = const Value.absent(),
    required String stationId,
    required String stationName,
    required int level,
    required int reporterId,
    required String transportType,
    this.direction = const Value.absent(),
    this.reportedAt = const Value.absent(),
  })  : stationId = Value(stationId),
        stationName = Value(stationName),
        level = Value(level),
        reporterId = Value(reporterId),
        transportType = Value(transportType);
  static Insertable<CrowdReport> custom({
    Expression<int>? id,
    Expression<String>? stationId,
    Expression<String>? stationName,
    Expression<int>? level,
    Expression<int>? reporterId,
    Expression<String>? transportType,
    Expression<String>? direction,
    Expression<DateTime>? reportedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (stationName != null) 'station_name': stationName,
      if (level != null) 'level': level,
      if (reporterId != null) 'reporter_id': reporterId,
      if (transportType != null) 'transport_type': transportType,
      if (direction != null) 'direction': direction,
      if (reportedAt != null) 'reported_at': reportedAt,
    });
  }

  CrowdReportsCompanion copyWith(
      {Value<int>? id,
      Value<String>? stationId,
      Value<String>? stationName,
      Value<int>? level,
      Value<int>? reporterId,
      Value<String>? transportType,
      Value<String?>? direction,
      Value<DateTime>? reportedAt}) {
    return CrowdReportsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      level: level ?? this.level,
      reporterId: reporterId ?? this.reporterId,
      transportType: transportType ?? this.transportType,
      direction: direction ?? this.direction,
      reportedAt: reportedAt ?? this.reportedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<String>(stationId.value);
    }
    if (stationName.present) {
      map['station_name'] = Variable<String>(stationName.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (reporterId.present) {
      map['reporter_id'] = Variable<int>(reporterId.value);
    }
    if (transportType.present) {
      map['transport_type'] = Variable<String>(transportType.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrowdReportsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('stationName: $stationName, ')
          ..write('level: $level, ')
          ..write('reporterId: $reporterId, ')
          ..write('transportType: $transportType, ')
          ..write('direction: $direction, ')
          ..write('reportedAt: $reportedAt')
          ..write(')'))
        .toString();
  }
}

class $IncidentsTable extends Incidents
    with TableInfo<$IncidentsTable, Incident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncidentsTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accelXMeta = const VerificationMeta('accelX');
  @override
  late final GeneratedColumn<double> accelX = GeneratedColumn<double>(
      'accel_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accelYMeta = const VerificationMeta('accelY');
  @override
  late final GeneratedColumn<double> accelY = GeneratedColumn<double>(
      'accel_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accelZMeta = const VerificationMeta('accelZ');
  @override
  late final GeneratedColumn<double> accelZ = GeneratedColumn<double>(
      'accel_z', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _magnitudeMeta =
      const VerificationMeta('magnitude');
  @override
  late final GeneratedColumn<double> magnitude = GeneratedColumn<double>(
      'magnitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationDescMeta =
      const VerificationMeta('locationDesc');
  @override
  late final GeneratedColumn<String> locationDesc = GeneratedColumn<String>(
      'location_desc', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notificationSentMeta =
      const VerificationMeta('notificationSent');
  @override
  late final GeneratedColumn<bool> notificationSent = GeneratedColumn<bool>(
      'notification_sent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_sent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _detectedAtMeta =
      const VerificationMeta('detectedAt');
  @override
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
      'detected_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        type,
        accelX,
        accelY,
        accelZ,
        magnitude,
        latitude,
        longitude,
        locationDesc,
        notificationSent,
        detectedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incidents';
  @override
  VerificationContext validateIntegrity(Insertable<Incident> instance,
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
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('accel_x')) {
      context.handle(_accelXMeta,
          accelX.isAcceptableOrUnknown(data['accel_x']!, _accelXMeta));
    } else if (isInserting) {
      context.missing(_accelXMeta);
    }
    if (data.containsKey('accel_y')) {
      context.handle(_accelYMeta,
          accelY.isAcceptableOrUnknown(data['accel_y']!, _accelYMeta));
    } else if (isInserting) {
      context.missing(_accelYMeta);
    }
    if (data.containsKey('accel_z')) {
      context.handle(_accelZMeta,
          accelZ.isAcceptableOrUnknown(data['accel_z']!, _accelZMeta));
    } else if (isInserting) {
      context.missing(_accelZMeta);
    }
    if (data.containsKey('magnitude')) {
      context.handle(_magnitudeMeta,
          magnitude.isAcceptableOrUnknown(data['magnitude']!, _magnitudeMeta));
    } else if (isInserting) {
      context.missing(_magnitudeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('location_desc')) {
      context.handle(
          _locationDescMeta,
          locationDesc.isAcceptableOrUnknown(
              data['location_desc']!, _locationDescMeta));
    }
    if (data.containsKey('notification_sent')) {
      context.handle(
          _notificationSentMeta,
          notificationSent.isAcceptableOrUnknown(
              data['notification_sent']!, _notificationSentMeta));
    }
    if (data.containsKey('detected_at')) {
      context.handle(
          _detectedAtMeta,
          detectedAt.isAcceptableOrUnknown(
              data['detected_at']!, _detectedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Incident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Incident(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      accelX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accel_x'])!,
      accelY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accel_y'])!,
      accelZ: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accel_z'])!,
      magnitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}magnitude'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      locationDesc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_desc']),
      notificationSent: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notification_sent'])!,
      detectedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}detected_at'])!,
    );
  }

  @override
  $IncidentsTable createAlias(String alias) {
    return $IncidentsTable(attachedDatabase, alias);
  }
}

class Incident extends DataClass implements Insertable<Incident> {
  final int id;
  final int userId;
  final String type;
  final double accelX;
  final double accelY;
  final double accelZ;
  final double magnitude;
  final double? latitude;
  final double? longitude;
  final String? locationDesc;
  final bool notificationSent;
  final DateTime detectedAt;
  const Incident(
      {required this.id,
      required this.userId,
      required this.type,
      required this.accelX,
      required this.accelY,
      required this.accelZ,
      required this.magnitude,
      this.latitude,
      this.longitude,
      this.locationDesc,
      required this.notificationSent,
      required this.detectedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['type'] = Variable<String>(type);
    map['accel_x'] = Variable<double>(accelX);
    map['accel_y'] = Variable<double>(accelY);
    map['accel_z'] = Variable<double>(accelZ);
    map['magnitude'] = Variable<double>(magnitude);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || locationDesc != null) {
      map['location_desc'] = Variable<String>(locationDesc);
    }
    map['notification_sent'] = Variable<bool>(notificationSent);
    map['detected_at'] = Variable<DateTime>(detectedAt);
    return map;
  }

  IncidentsCompanion toCompanion(bool nullToAbsent) {
    return IncidentsCompanion(
      id: Value(id),
      userId: Value(userId),
      type: Value(type),
      accelX: Value(accelX),
      accelY: Value(accelY),
      accelZ: Value(accelZ),
      magnitude: Value(magnitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      locationDesc: locationDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(locationDesc),
      notificationSent: Value(notificationSent),
      detectedAt: Value(detectedAt),
    );
  }

  factory Incident.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Incident(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      accelX: serializer.fromJson<double>(json['accelX']),
      accelY: serializer.fromJson<double>(json['accelY']),
      accelZ: serializer.fromJson<double>(json['accelZ']),
      magnitude: serializer.fromJson<double>(json['magnitude']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      locationDesc: serializer.fromJson<String?>(json['locationDesc']),
      notificationSent: serializer.fromJson<bool>(json['notificationSent']),
      detectedAt: serializer.fromJson<DateTime>(json['detectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'type': serializer.toJson<String>(type),
      'accelX': serializer.toJson<double>(accelX),
      'accelY': serializer.toJson<double>(accelY),
      'accelZ': serializer.toJson<double>(accelZ),
      'magnitude': serializer.toJson<double>(magnitude),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'locationDesc': serializer.toJson<String?>(locationDesc),
      'notificationSent': serializer.toJson<bool>(notificationSent),
      'detectedAt': serializer.toJson<DateTime>(detectedAt),
    };
  }

  Incident copyWith(
          {int? id,
          int? userId,
          String? type,
          double? accelX,
          double? accelY,
          double? accelZ,
          double? magnitude,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> locationDesc = const Value.absent(),
          bool? notificationSent,
          DateTime? detectedAt}) =>
      Incident(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        accelX: accelX ?? this.accelX,
        accelY: accelY ?? this.accelY,
        accelZ: accelZ ?? this.accelZ,
        magnitude: magnitude ?? this.magnitude,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        locationDesc:
            locationDesc.present ? locationDesc.value : this.locationDesc,
        notificationSent: notificationSent ?? this.notificationSent,
        detectedAt: detectedAt ?? this.detectedAt,
      );
  Incident copyWithCompanion(IncidentsCompanion data) {
    return Incident(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      accelX: data.accelX.present ? data.accelX.value : this.accelX,
      accelY: data.accelY.present ? data.accelY.value : this.accelY,
      accelZ: data.accelZ.present ? data.accelZ.value : this.accelZ,
      magnitude: data.magnitude.present ? data.magnitude.value : this.magnitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      locationDesc: data.locationDesc.present
          ? data.locationDesc.value
          : this.locationDesc,
      notificationSent: data.notificationSent.present
          ? data.notificationSent.value
          : this.notificationSent,
      detectedAt:
          data.detectedAt.present ? data.detectedAt.value : this.detectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Incident(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('accelX: $accelX, ')
          ..write('accelY: $accelY, ')
          ..write('accelZ: $accelZ, ')
          ..write('magnitude: $magnitude, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationDesc: $locationDesc, ')
          ..write('notificationSent: $notificationSent, ')
          ..write('detectedAt: $detectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      type,
      accelX,
      accelY,
      accelZ,
      magnitude,
      latitude,
      longitude,
      locationDesc,
      notificationSent,
      detectedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Incident &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.accelX == this.accelX &&
          other.accelY == this.accelY &&
          other.accelZ == this.accelZ &&
          other.magnitude == this.magnitude &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.locationDesc == this.locationDesc &&
          other.notificationSent == this.notificationSent &&
          other.detectedAt == this.detectedAt);
}

class IncidentsCompanion extends UpdateCompanion<Incident> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> type;
  final Value<double> accelX;
  final Value<double> accelY;
  final Value<double> accelZ;
  final Value<double> magnitude;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> locationDesc;
  final Value<bool> notificationSent;
  final Value<DateTime> detectedAt;
  const IncidentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.accelX = const Value.absent(),
    this.accelY = const Value.absent(),
    this.accelZ = const Value.absent(),
    this.magnitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationDesc = const Value.absent(),
    this.notificationSent = const Value.absent(),
    this.detectedAt = const Value.absent(),
  });
  IncidentsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String type,
    required double accelX,
    required double accelY,
    required double accelZ,
    required double magnitude,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.locationDesc = const Value.absent(),
    this.notificationSent = const Value.absent(),
    this.detectedAt = const Value.absent(),
  })  : userId = Value(userId),
        type = Value(type),
        accelX = Value(accelX),
        accelY = Value(accelY),
        accelZ = Value(accelZ),
        magnitude = Value(magnitude);
  static Insertable<Incident> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? type,
    Expression<double>? accelX,
    Expression<double>? accelY,
    Expression<double>? accelZ,
    Expression<double>? magnitude,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? locationDesc,
    Expression<bool>? notificationSent,
    Expression<DateTime>? detectedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (accelX != null) 'accel_x': accelX,
      if (accelY != null) 'accel_y': accelY,
      if (accelZ != null) 'accel_z': accelZ,
      if (magnitude != null) 'magnitude': magnitude,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locationDesc != null) 'location_desc': locationDesc,
      if (notificationSent != null) 'notification_sent': notificationSent,
      if (detectedAt != null) 'detected_at': detectedAt,
    });
  }

  IncidentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? type,
      Value<double>? accelX,
      Value<double>? accelY,
      Value<double>? accelZ,
      Value<double>? magnitude,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? locationDesc,
      Value<bool>? notificationSent,
      Value<DateTime>? detectedAt}) {
    return IncidentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      accelX: accelX ?? this.accelX,
      accelY: accelY ?? this.accelY,
      accelZ: accelZ ?? this.accelZ,
      magnitude: magnitude ?? this.magnitude,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationDesc: locationDesc ?? this.locationDesc,
      notificationSent: notificationSent ?? this.notificationSent,
      detectedAt: detectedAt ?? this.detectedAt,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (accelX.present) {
      map['accel_x'] = Variable<double>(accelX.value);
    }
    if (accelY.present) {
      map['accel_y'] = Variable<double>(accelY.value);
    }
    if (accelZ.present) {
      map['accel_z'] = Variable<double>(accelZ.value);
    }
    if (magnitude.present) {
      map['magnitude'] = Variable<double>(magnitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (locationDesc.present) {
      map['location_desc'] = Variable<String>(locationDesc.value);
    }
    if (notificationSent.present) {
      map['notification_sent'] = Variable<bool>(notificationSent.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncidentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('accelX: $accelX, ')
          ..write('accelY: $accelY, ')
          ..write('accelZ: $accelZ, ')
          ..write('magnitude: $magnitude, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('locationDesc: $locationDesc, ')
          ..write('notificationSent: $notificationSent, ')
          ..write('detectedAt: $detectedAt')
          ..write(')'))
        .toString();
  }
}

class $GameScoresTable extends GameScores
    with TableInfo<$GameScoresTable, GameScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameScoresTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeUsedMeta =
      const VerificationMeta('timeUsed');
  @override
  late final GeneratedColumn<int> timeUsed = GeneratedColumn<int>(
      'time_used', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, level, score, timeUsed, completed, playedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_scores';
  @override
  VerificationContext validateIntegrity(Insertable<GameScore> instance,
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
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('time_used')) {
      context.handle(_timeUsedMeta,
          timeUsed.isAcceptableOrUnknown(data['time_used']!, _timeUsedMeta));
    } else if (isInserting) {
      context.missing(_timeUsedMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameScore(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      timeUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_used'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
    );
  }

  @override
  $GameScoresTable createAlias(String alias) {
    return $GameScoresTable(attachedDatabase, alias);
  }
}

class GameScore extends DataClass implements Insertable<GameScore> {
  final int id;
  final int userId;
  final int level;
  final int score;
  final int timeUsed;
  final bool completed;
  final DateTime playedAt;
  const GameScore(
      {required this.id,
      required this.userId,
      required this.level,
      required this.score,
      required this.timeUsed,
      required this.completed,
      required this.playedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['level'] = Variable<int>(level);
    map['score'] = Variable<int>(score);
    map['time_used'] = Variable<int>(timeUsed);
    map['completed'] = Variable<bool>(completed);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  GameScoresCompanion toCompanion(bool nullToAbsent) {
    return GameScoresCompanion(
      id: Value(id),
      userId: Value(userId),
      level: Value(level),
      score: Value(score),
      timeUsed: Value(timeUsed),
      completed: Value(completed),
      playedAt: Value(playedAt),
    );
  }

  factory GameScore.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameScore(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      level: serializer.fromJson<int>(json['level']),
      score: serializer.fromJson<int>(json['score']),
      timeUsed: serializer.fromJson<int>(json['timeUsed']),
      completed: serializer.fromJson<bool>(json['completed']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'level': serializer.toJson<int>(level),
      'score': serializer.toJson<int>(score),
      'timeUsed': serializer.toJson<int>(timeUsed),
      'completed': serializer.toJson<bool>(completed),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  GameScore copyWith(
          {int? id,
          int? userId,
          int? level,
          int? score,
          int? timeUsed,
          bool? completed,
          DateTime? playedAt}) =>
      GameScore(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        level: level ?? this.level,
        score: score ?? this.score,
        timeUsed: timeUsed ?? this.timeUsed,
        completed: completed ?? this.completed,
        playedAt: playedAt ?? this.playedAt,
      );
  GameScore copyWithCompanion(GameScoresCompanion data) {
    return GameScore(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      level: data.level.present ? data.level.value : this.level,
      score: data.score.present ? data.score.value : this.score,
      timeUsed: data.timeUsed.present ? data.timeUsed.value : this.timeUsed,
      completed: data.completed.present ? data.completed.value : this.completed,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameScore(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('level: $level, ')
          ..write('score: $score, ')
          ..write('timeUsed: $timeUsed, ')
          ..write('completed: $completed, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, level, score, timeUsed, completed, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameScore &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.level == this.level &&
          other.score == this.score &&
          other.timeUsed == this.timeUsed &&
          other.completed == this.completed &&
          other.playedAt == this.playedAt);
}

class GameScoresCompanion extends UpdateCompanion<GameScore> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> level;
  final Value<int> score;
  final Value<int> timeUsed;
  final Value<bool> completed;
  final Value<DateTime> playedAt;
  const GameScoresCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.level = const Value.absent(),
    this.score = const Value.absent(),
    this.timeUsed = const Value.absent(),
    this.completed = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  GameScoresCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int level,
    required int score,
    required int timeUsed,
    this.completed = const Value.absent(),
    this.playedAt = const Value.absent(),
  })  : userId = Value(userId),
        level = Value(level),
        score = Value(score),
        timeUsed = Value(timeUsed);
  static Insertable<GameScore> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? level,
    Expression<int>? score,
    Expression<int>? timeUsed,
    Expression<bool>? completed,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (level != null) 'level': level,
      if (score != null) 'score': score,
      if (timeUsed != null) 'time_used': timeUsed,
      if (completed != null) 'completed': completed,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  GameScoresCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int>? level,
      Value<int>? score,
      Value<int>? timeUsed,
      Value<bool>? completed,
      Value<DateTime>? playedAt}) {
    return GameScoresCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      level: level ?? this.level,
      score: score ?? this.score,
      timeUsed: timeUsed ?? this.timeUsed,
      completed: completed ?? this.completed,
      playedAt: playedAt ?? this.playedAt,
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
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (timeUsed.present) {
      map['time_used'] = Variable<int>(timeUsed.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameScoresCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('level: $level, ')
          ..write('score: $score, ')
          ..write('timeUsed: $timeUsed, ')
          ..write('completed: $completed, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $FeedbackEntriesTable extends FeedbackEntries
    with TableInfo<$FeedbackEntriesTable, FeedbackEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedbackEntriesTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
      'subject', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saranMeta = const VerificationMeta('saran');
  @override
  late final GeneratedColumn<String> saran = GeneratedColumn<String>(
      'saran', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kesanMeta = const VerificationMeta('kesan');
  @override
  late final GeneratedColumn<String> kesan = GeneratedColumn<String>(
      'kesan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, subject, saran, kesan, rating, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedback_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FeedbackEntry> instance,
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
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('saran')) {
      context.handle(
          _saranMeta, saran.isAcceptableOrUnknown(data['saran']!, _saranMeta));
    } else if (isInserting) {
      context.missing(_saranMeta);
    }
    if (data.containsKey('kesan')) {
      context.handle(
          _kesanMeta, kesan.isAcceptableOrUnknown(data['kesan']!, _kesanMeta));
    } else if (isInserting) {
      context.missing(_kesanMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedbackEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedbackEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject'])!,
      saran: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}saran'])!,
      kesan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kesan'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FeedbackEntriesTable createAlias(String alias) {
    return $FeedbackEntriesTable(attachedDatabase, alias);
  }
}

class FeedbackEntry extends DataClass implements Insertable<FeedbackEntry> {
  final int id;
  final int userId;
  final String subject;
  final String saran;
  final String kesan;
  final int rating;
  final DateTime createdAt;
  const FeedbackEntry(
      {required this.id,
      required this.userId,
      required this.subject,
      required this.saran,
      required this.kesan,
      required this.rating,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['subject'] = Variable<String>(subject);
    map['saran'] = Variable<String>(saran);
    map['kesan'] = Variable<String>(kesan);
    map['rating'] = Variable<int>(rating);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FeedbackEntriesCompanion toCompanion(bool nullToAbsent) {
    return FeedbackEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      subject: Value(subject),
      saran: Value(saran),
      kesan: Value(kesan),
      rating: Value(rating),
      createdAt: Value(createdAt),
    );
  }

  factory FeedbackEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedbackEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      subject: serializer.fromJson<String>(json['subject']),
      saran: serializer.fromJson<String>(json['saran']),
      kesan: serializer.fromJson<String>(json['kesan']),
      rating: serializer.fromJson<int>(json['rating']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'subject': serializer.toJson<String>(subject),
      'saran': serializer.toJson<String>(saran),
      'kesan': serializer.toJson<String>(kesan),
      'rating': serializer.toJson<int>(rating),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FeedbackEntry copyWith(
          {int? id,
          int? userId,
          String? subject,
          String? saran,
          String? kesan,
          int? rating,
          DateTime? createdAt}) =>
      FeedbackEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        subject: subject ?? this.subject,
        saran: saran ?? this.saran,
        kesan: kesan ?? this.kesan,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
      );
  FeedbackEntry copyWithCompanion(FeedbackEntriesCompanion data) {
    return FeedbackEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      subject: data.subject.present ? data.subject.value : this.subject,
      saran: data.saran.present ? data.saran.value : this.saran,
      kesan: data.kesan.present ? data.kesan.value : this.kesan,
      rating: data.rating.present ? data.rating.value : this.rating,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('subject: $subject, ')
          ..write('saran: $saran, ')
          ..write('kesan: $kesan, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, subject, saran, kesan, rating, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedbackEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.subject == this.subject &&
          other.saran == this.saran &&
          other.kesan == this.kesan &&
          other.rating == this.rating &&
          other.createdAt == this.createdAt);
}

class FeedbackEntriesCompanion extends UpdateCompanion<FeedbackEntry> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> subject;
  final Value<String> saran;
  final Value<String> kesan;
  final Value<int> rating;
  final Value<DateTime> createdAt;
  const FeedbackEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.subject = const Value.absent(),
    this.saran = const Value.absent(),
    this.kesan = const Value.absent(),
    this.rating = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FeedbackEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String subject,
    required String saran,
    required String kesan,
    required int rating,
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        subject = Value(subject),
        saran = Value(saran),
        kesan = Value(kesan),
        rating = Value(rating);
  static Insertable<FeedbackEntry> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? subject,
    Expression<String>? saran,
    Expression<String>? kesan,
    Expression<int>? rating,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (subject != null) 'subject': subject,
      if (saran != null) 'saran': saran,
      if (kesan != null) 'kesan': kesan,
      if (rating != null) 'rating': rating,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FeedbackEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? subject,
      Value<String>? saran,
      Value<String>? kesan,
      Value<int>? rating,
      Value<DateTime>? createdAt}) {
    return FeedbackEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subject: subject ?? this.subject,
      saran: saran ?? this.saran,
      kesan: kesan ?? this.kesan,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
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
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (saran.present) {
      map['saran'] = Variable<String>(saran.value);
    }
    if (kesan.present) {
      map['kesan'] = Variable<String>(kesan.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('subject: $subject, ')
          ..write('saran: $saran, ')
          ..write('kesan: $kesan, ')
          ..write('rating: $rating, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FavoriteRoutesTable extends FavoriteRoutes
    with TableInfo<$FavoriteRoutesTable, FavoriteRoute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteRoutesTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _destinationMeta =
      const VerificationMeta('destination');
  @override
  late final GeneratedColumn<String> destination = GeneratedColumn<String>(
      'destination', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transportModesMeta =
      const VerificationMeta('transportModes');
  @override
  late final GeneratedColumn<String> transportModes = GeneratedColumn<String>(
      'transport_modes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, name, origin, destination, transportModes, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_routes';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteRoute> instance,
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
          _destinationMeta,
          destination.isAcceptableOrUnknown(
              data['destination']!, _destinationMeta));
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('transport_modes')) {
      context.handle(
          _transportModesMeta,
          transportModes.isAcceptableOrUnknown(
              data['transport_modes']!, _transportModesMeta));
    } else if (isInserting) {
      context.missing(_transportModesMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteRoute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRoute(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      destination: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}destination'])!,
      transportModes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transport_modes'])!,
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $FavoriteRoutesTable createAlias(String alias) {
    return $FavoriteRoutesTable(attachedDatabase, alias);
  }
}

class FavoriteRoute extends DataClass implements Insertable<FavoriteRoute> {
  final int id;
  final int userId;
  final String name;
  final String origin;
  final String destination;
  final String transportModes;
  final DateTime savedAt;
  const FavoriteRoute(
      {required this.id,
      required this.userId,
      required this.name,
      required this.origin,
      required this.destination,
      required this.transportModes,
      required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['origin'] = Variable<String>(origin);
    map['destination'] = Variable<String>(destination);
    map['transport_modes'] = Variable<String>(transportModes);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoriteRoutesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteRoutesCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      origin: Value(origin),
      destination: Value(destination),
      transportModes: Value(transportModes),
      savedAt: Value(savedAt),
    );
  }

  factory FavoriteRoute.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRoute(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      origin: serializer.fromJson<String>(json['origin']),
      destination: serializer.fromJson<String>(json['destination']),
      transportModes: serializer.fromJson<String>(json['transportModes']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'origin': serializer.toJson<String>(origin),
      'destination': serializer.toJson<String>(destination),
      'transportModes': serializer.toJson<String>(transportModes),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoriteRoute copyWith(
          {int? id,
          int? userId,
          String? name,
          String? origin,
          String? destination,
          String? transportModes,
          DateTime? savedAt}) =>
      FavoriteRoute(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        transportModes: transportModes ?? this.transportModes,
        savedAt: savedAt ?? this.savedAt,
      );
  FavoriteRoute copyWithCompanion(FavoriteRoutesCompanion data) {
    return FavoriteRoute(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      origin: data.origin.present ? data.origin.value : this.origin,
      destination:
          data.destination.present ? data.destination.value : this.destination,
      transportModes: data.transportModes.present
          ? data.transportModes.value
          : this.transportModes,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRoute(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('transportModes: $transportModes, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, name, origin, destination, transportModes, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRoute &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.origin == this.origin &&
          other.destination == this.destination &&
          other.transportModes == this.transportModes &&
          other.savedAt == this.savedAt);
}

class FavoriteRoutesCompanion extends UpdateCompanion<FavoriteRoute> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<String> origin;
  final Value<String> destination;
  final Value<String> transportModes;
  final Value<DateTime> savedAt;
  const FavoriteRoutesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.origin = const Value.absent(),
    this.destination = const Value.absent(),
    this.transportModes = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  FavoriteRoutesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    required String origin,
    required String destination,
    required String transportModes,
    this.savedAt = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        origin = Value(origin),
        destination = Value(destination),
        transportModes = Value(transportModes);
  static Insertable<FavoriteRoute> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? origin,
    Expression<String>? destination,
    Expression<String>? transportModes,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (origin != null) 'origin': origin,
      if (destination != null) 'destination': destination,
      if (transportModes != null) 'transport_modes': transportModes,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  FavoriteRoutesCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? name,
      Value<String>? origin,
      Value<String>? destination,
      Value<String>? transportModes,
      Value<DateTime>? savedAt}) {
    return FavoriteRoutesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      transportModes: transportModes ?? this.transportModes,
      savedAt: savedAt ?? this.savedAt,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (transportModes.present) {
      map['transport_modes'] = Variable<String>(transportModes.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRoutesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('origin: $origin, ')
          ..write('destination: $destination, ')
          ..write('transportModes: $transportModes, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $CrowdReportsTable crowdReports = $CrowdReportsTable(this);
  late final $IncidentsTable incidents = $IncidentsTable(this);
  late final $GameScoresTable gameScores = $GameScoresTable(this);
  late final $FeedbackEntriesTable feedbackEntries =
      $FeedbackEntriesTable(this);
  late final $FavoriteRoutesTable favoriteRoutes = $FavoriteRoutesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        trips,
        crowdReports,
        incidents,
        gameScores,
        feedbackEntries,
        favoriteRoutes
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String email,
  required String passwordHash,
  required String salt,
  Value<String?> fullName,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<bool> biometricEnabled,
  Value<String?> sessionToken,
  Value<DateTime?> sessionExpiry,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> email,
  Value<String> passwordHash,
  Value<String> salt,
  Value<String?> fullName,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<bool> biometricEnabled,
  Value<String?> sessionToken,
  Value<DateTime?> sessionExpiry,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TripsTable, List<Trip>> _tripsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.trips,
          aliasName: $_aliasNameGenerator(db.users.id, db.trips.userId));

  $$TripsTableProcessedTableManager get tripsRefs {
    final manager = $$TripsTableTableManager($_db, $_db.trips)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_tripsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CrowdReportsTable, List<CrowdReport>>
      _crowdReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.crowdReports,
          aliasName:
              $_aliasNameGenerator(db.users.id, db.crowdReports.reporterId));

  $$CrowdReportsTableProcessedTableManager get crowdReportsRefs {
    final manager = $$CrowdReportsTableTableManager($_db, $_db.crowdReports)
        .filter((f) => f.reporterId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_crowdReportsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IncidentsTable, List<Incident>>
      _incidentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.incidents,
          aliasName: $_aliasNameGenerator(db.users.id, db.incidents.userId));

  $$IncidentsTableProcessedTableManager get incidentsRefs {
    final manager = $$IncidentsTableTableManager($_db, $_db.incidents)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_incidentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GameScoresTable, List<GameScore>>
      _gameScoresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.gameScores,
          aliasName: $_aliasNameGenerator(db.users.id, db.gameScores.userId));

  $$GameScoresTableProcessedTableManager get gameScoresRefs {
    final manager = $$GameScoresTableTableManager($_db, $_db.gameScores)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_gameScoresRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeedbackEntriesTable, List<FeedbackEntry>>
      _feedbackEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.feedbackEntries,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.feedbackEntries.userId));

  $$FeedbackEntriesTableProcessedTableManager get feedbackEntriesRefs {
    final manager =
        $$FeedbackEntriesTableTableManager($_db, $_db.feedbackEntries)
            .filter((f) => f.userId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_feedbackEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FavoriteRoutesTable, List<FavoriteRoute>>
      _favoriteRoutesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.favoriteRoutes,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.favoriteRoutes.userId));

  $$FavoriteRoutesTableProcessedTableManager get favoriteRoutesRefs {
    final manager = $$FavoriteRoutesTableTableManager($_db, $_db.favoriteRoutes)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_favoriteRoutesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sessionExpiry => $composableBuilder(
      column: $table.sessionExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> tripsRefs(
      Expression<bool> Function($$TripsTableFilterComposer f) f) {
    final $$TripsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trips,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TripsTableFilterComposer(
              $db: $db,
              $table: $db.trips,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> crowdReportsRefs(
      Expression<bool> Function($$CrowdReportsTableFilterComposer f) f) {
    final $$CrowdReportsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.crowdReports,
        getReferencedColumn: (t) => t.reporterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CrowdReportsTableFilterComposer(
              $db: $db,
              $table: $db.crowdReports,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> incidentsRefs(
      Expression<bool> Function($$IncidentsTableFilterComposer f) f) {
    final $$IncidentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incidents,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncidentsTableFilterComposer(
              $db: $db,
              $table: $db.incidents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> gameScoresRefs(
      Expression<bool> Function($$GameScoresTableFilterComposer f) f) {
    final $$GameScoresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameScores,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameScoresTableFilterComposer(
              $db: $db,
              $table: $db.gameScores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feedbackEntriesRefs(
      Expression<bool> Function($$FeedbackEntriesTableFilterComposer f) f) {
    final $$FeedbackEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feedbackEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedbackEntriesTableFilterComposer(
              $db: $db,
              $table: $db.feedbackEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> favoriteRoutesRefs(
      Expression<bool> Function($$FavoriteRoutesTableFilterComposer f) f) {
    final $$FavoriteRoutesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoriteRoutes,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoriteRoutesTableFilterComposer(
              $db: $db,
              $table: $db.favoriteRoutes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sessionExpiry => $composableBuilder(
      column: $table.sessionExpiry,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
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

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled, builder: (column) => column);

  GeneratedColumn<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionExpiry => $composableBuilder(
      column: $table.sessionExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> tripsRefs<T extends Object>(
      Expression<T> Function($$TripsTableAnnotationComposer a) f) {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trips,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TripsTableAnnotationComposer(
              $db: $db,
              $table: $db.trips,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> crowdReportsRefs<T extends Object>(
      Expression<T> Function($$CrowdReportsTableAnnotationComposer a) f) {
    final $$CrowdReportsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.crowdReports,
        getReferencedColumn: (t) => t.reporterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CrowdReportsTableAnnotationComposer(
              $db: $db,
              $table: $db.crowdReports,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> incidentsRefs<T extends Object>(
      Expression<T> Function($$IncidentsTableAnnotationComposer a) f) {
    final $$IncidentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incidents,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncidentsTableAnnotationComposer(
              $db: $db,
              $table: $db.incidents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> gameScoresRefs<T extends Object>(
      Expression<T> Function($$GameScoresTableAnnotationComposer a) f) {
    final $$GameScoresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameScores,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameScoresTableAnnotationComposer(
              $db: $db,
              $table: $db.gameScores,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feedbackEntriesRefs<T extends Object>(
      Expression<T> Function($$FeedbackEntriesTableAnnotationComposer a) f) {
    final $$FeedbackEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feedbackEntries,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeedbackEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.feedbackEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> favoriteRoutesRefs<T extends Object>(
      Expression<T> Function($$FavoriteRoutesTableAnnotationComposer a) f) {
    final $$FavoriteRoutesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoriteRoutes,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoriteRoutesTableAnnotationComposer(
              $db: $db,
              $table: $db.favoriteRoutes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool tripsRefs,
        bool crowdReportsRefs,
        bool incidentsRefs,
        bool gameScoresRefs,
        bool feedbackEntriesRefs,
        bool favoriteRoutesRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> salt = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<bool> biometricEnabled = const Value.absent(),
            Value<String?> sessionToken = const Value.absent(),
            Value<DateTime?> sessionExpiry = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
            fullName: fullName,
            phone: phone,
            photoPath: photoPath,
            biometricEnabled: biometricEnabled,
            sessionToken: sessionToken,
            sessionExpiry: sessionExpiry,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String email,
            required String passwordHash,
            required String salt,
            Value<String?> fullName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<bool> biometricEnabled = const Value.absent(),
            Value<String?> sessionToken = const Value.absent(),
            Value<DateTime?> sessionExpiry = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
            fullName: fullName,
            phone: phone,
            photoPath: photoPath,
            biometricEnabled: biometricEnabled,
            sessionToken: sessionToken,
            sessionExpiry: sessionExpiry,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {tripsRefs = false,
              crowdReportsRefs = false,
              incidentsRefs = false,
              gameScoresRefs = false,
              feedbackEntriesRefs = false,
              favoriteRoutesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tripsRefs) db.trips,
                if (crowdReportsRefs) db.crowdReports,
                if (incidentsRefs) db.incidents,
                if (gameScoresRefs) db.gameScores,
                if (feedbackEntriesRefs) db.feedbackEntries,
                if (favoriteRoutesRefs) db.favoriteRoutes
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tripsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._tripsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).tripsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (crowdReportsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._crowdReportsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .crowdReportsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.reporterId == item.id),
                        typedResults: items),
                  if (incidentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._incidentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).incidentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (gameScoresRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._gameScoresRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .gameScoresRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (feedbackEntriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._feedbackEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .feedbackEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (favoriteRoutesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._favoriteRoutesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .favoriteRoutesRefs,
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

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool tripsRefs,
        bool crowdReportsRefs,
        bool incidentsRefs,
        bool gameScoresRefs,
        bool feedbackEntriesRefs,
        bool favoriteRoutesRefs})>;
typedef $$TripsTableCreateCompanionBuilder = TripsCompanion Function({
  Value<int> id,
  required int userId,
  required String origin,
  required String destination,
  required String routeJson,
  required String transportModes,
  Value<double?> crowdScore,
  Value<double?> estimatedMinutes,
  Value<double?> fareIdr,
  Value<DateTime> tripDate,
});
typedef $$TripsTableUpdateCompanionBuilder = TripsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> origin,
  Value<String> destination,
  Value<String> routeJson,
  Value<String> transportModes,
  Value<double?> crowdScore,
  Value<double?> estimatedMinutes,
  Value<double?> fareIdr,
  Value<DateTime> tripDate,
});

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, Trip> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.trips.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get routeJson => $composableBuilder(
      column: $table.routeJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transportModes => $composableBuilder(
      column: $table.transportModes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get crowdScore => $composableBuilder(
      column: $table.crowdScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fareIdr => $composableBuilder(
      column: $table.fareIdr, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tripDate => $composableBuilder(
      column: $table.tripDate, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get routeJson => $composableBuilder(
      column: $table.routeJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transportModes => $composableBuilder(
      column: $table.transportModes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get crowdScore => $composableBuilder(
      column: $table.crowdScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fareIdr => $composableBuilder(
      column: $table.fareIdr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tripDate => $composableBuilder(
      column: $table.tripDate, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => column);

  GeneratedColumn<String> get routeJson =>
      $composableBuilder(column: $table.routeJson, builder: (column) => column);

  GeneratedColumn<String> get transportModes => $composableBuilder(
      column: $table.transportModes, builder: (column) => column);

  GeneratedColumn<double> get crowdScore => $composableBuilder(
      column: $table.crowdScore, builder: (column) => column);

  GeneratedColumn<double> get estimatedMinutes => $composableBuilder(
      column: $table.estimatedMinutes, builder: (column) => column);

  GeneratedColumn<double> get fareIdr =>
      $composableBuilder(column: $table.fareIdr, builder: (column) => column);

  GeneratedColumn<DateTime> get tripDate =>
      $composableBuilder(column: $table.tripDate, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TripsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TripsTable,
    Trip,
    $$TripsTableFilterComposer,
    $$TripsTableOrderingComposer,
    $$TripsTableAnnotationComposer,
    $$TripsTableCreateCompanionBuilder,
    $$TripsTableUpdateCompanionBuilder,
    (Trip, $$TripsTableReferences),
    Trip,
    PrefetchHooks Function({bool userId})> {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> destination = const Value.absent(),
            Value<String> routeJson = const Value.absent(),
            Value<String> transportModes = const Value.absent(),
            Value<double?> crowdScore = const Value.absent(),
            Value<double?> estimatedMinutes = const Value.absent(),
            Value<double?> fareIdr = const Value.absent(),
            Value<DateTime> tripDate = const Value.absent(),
          }) =>
              TripsCompanion(
            id: id,
            userId: userId,
            origin: origin,
            destination: destination,
            routeJson: routeJson,
            transportModes: transportModes,
            crowdScore: crowdScore,
            estimatedMinutes: estimatedMinutes,
            fareIdr: fareIdr,
            tripDate: tripDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String origin,
            required String destination,
            required String routeJson,
            required String transportModes,
            Value<double?> crowdScore = const Value.absent(),
            Value<double?> estimatedMinutes = const Value.absent(),
            Value<double?> fareIdr = const Value.absent(),
            Value<DateTime> tripDate = const Value.absent(),
          }) =>
              TripsCompanion.insert(
            id: id,
            userId: userId,
            origin: origin,
            destination: destination,
            routeJson: routeJson,
            transportModes: transportModes,
            crowdScore: crowdScore,
            estimatedMinutes: estimatedMinutes,
            fareIdr: fareIdr,
            tripDate: tripDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TripsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                    referencedTable: $$TripsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$TripsTableReferences._userIdTable(db).id,
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

typedef $$TripsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TripsTable,
    Trip,
    $$TripsTableFilterComposer,
    $$TripsTableOrderingComposer,
    $$TripsTableAnnotationComposer,
    $$TripsTableCreateCompanionBuilder,
    $$TripsTableUpdateCompanionBuilder,
    (Trip, $$TripsTableReferences),
    Trip,
    PrefetchHooks Function({bool userId})>;
typedef $$CrowdReportsTableCreateCompanionBuilder = CrowdReportsCompanion
    Function({
  Value<int> id,
  required String stationId,
  required String stationName,
  required int level,
  required int reporterId,
  required String transportType,
  Value<String?> direction,
  Value<DateTime> reportedAt,
});
typedef $$CrowdReportsTableUpdateCompanionBuilder = CrowdReportsCompanion
    Function({
  Value<int> id,
  Value<String> stationId,
  Value<String> stationName,
  Value<int> level,
  Value<int> reporterId,
  Value<String> transportType,
  Value<String?> direction,
  Value<DateTime> reportedAt,
});

final class $$CrowdReportsTableReferences
    extends BaseReferences<_$AppDatabase, $CrowdReportsTable, CrowdReport> {
  $$CrowdReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _reporterIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.crowdReports.reporterId, db.users.id));

  $$UsersTableProcessedTableManager? get reporterId {
    if ($_item.reporterId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.reporterId!));
    final item = $_typedResult.readTableOrNull(_reporterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CrowdReportsTableFilterComposer
    extends Composer<_$AppDatabase, $CrowdReportsTable> {
  $$CrowdReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stationId => $composableBuilder(
      column: $table.stationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stationName => $composableBuilder(
      column: $table.stationName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transportType => $composableBuilder(
      column: $table.transportType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get reporterId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reporterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CrowdReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $CrowdReportsTable> {
  $$CrowdReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stationId => $composableBuilder(
      column: $table.stationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stationName => $composableBuilder(
      column: $table.stationName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transportType => $composableBuilder(
      column: $table.transportType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get reporterId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reporterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CrowdReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrowdReportsTable> {
  $$CrowdReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stationId =>
      $composableBuilder(column: $table.stationId, builder: (column) => column);

  GeneratedColumn<String> get stationName => $composableBuilder(
      column: $table.stationName, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get transportType => $composableBuilder(
      column: $table.transportType, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
      column: $table.reportedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get reporterId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reporterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CrowdReportsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CrowdReportsTable,
    CrowdReport,
    $$CrowdReportsTableFilterComposer,
    $$CrowdReportsTableOrderingComposer,
    $$CrowdReportsTableAnnotationComposer,
    $$CrowdReportsTableCreateCompanionBuilder,
    $$CrowdReportsTableUpdateCompanionBuilder,
    (CrowdReport, $$CrowdReportsTableReferences),
    CrowdReport,
    PrefetchHooks Function({bool reporterId})> {
  $$CrowdReportsTableTableManager(_$AppDatabase db, $CrowdReportsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrowdReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrowdReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrowdReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> stationId = const Value.absent(),
            Value<String> stationName = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> reporterId = const Value.absent(),
            Value<String> transportType = const Value.absent(),
            Value<String?> direction = const Value.absent(),
            Value<DateTime> reportedAt = const Value.absent(),
          }) =>
              CrowdReportsCompanion(
            id: id,
            stationId: stationId,
            stationName: stationName,
            level: level,
            reporterId: reporterId,
            transportType: transportType,
            direction: direction,
            reportedAt: reportedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String stationId,
            required String stationName,
            required int level,
            required int reporterId,
            required String transportType,
            Value<String?> direction = const Value.absent(),
            Value<DateTime> reportedAt = const Value.absent(),
          }) =>
              CrowdReportsCompanion.insert(
            id: id,
            stationId: stationId,
            stationName: stationName,
            level: level,
            reporterId: reporterId,
            transportType: transportType,
            direction: direction,
            reportedAt: reportedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CrowdReportsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({reporterId = false}) {
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
                if (reporterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.reporterId,
                    referencedTable:
                        $$CrowdReportsTableReferences._reporterIdTable(db),
                    referencedColumn:
                        $$CrowdReportsTableReferences._reporterIdTable(db).id,
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

typedef $$CrowdReportsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CrowdReportsTable,
    CrowdReport,
    $$CrowdReportsTableFilterComposer,
    $$CrowdReportsTableOrderingComposer,
    $$CrowdReportsTableAnnotationComposer,
    $$CrowdReportsTableCreateCompanionBuilder,
    $$CrowdReportsTableUpdateCompanionBuilder,
    (CrowdReport, $$CrowdReportsTableReferences),
    CrowdReport,
    PrefetchHooks Function({bool reporterId})>;
typedef $$IncidentsTableCreateCompanionBuilder = IncidentsCompanion Function({
  Value<int> id,
  required int userId,
  required String type,
  required double accelX,
  required double accelY,
  required double accelZ,
  required double magnitude,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> locationDesc,
  Value<bool> notificationSent,
  Value<DateTime> detectedAt,
});
typedef $$IncidentsTableUpdateCompanionBuilder = IncidentsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> type,
  Value<double> accelX,
  Value<double> accelY,
  Value<double> accelZ,
  Value<double> magnitude,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> locationDesc,
  Value<bool> notificationSent,
  Value<DateTime> detectedAt,
});

final class $$IncidentsTableReferences
    extends BaseReferences<_$AppDatabase, $IncidentsTable, Incident> {
  $$IncidentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.incidents.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IncidentsTableFilterComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accelX => $composableBuilder(
      column: $table.accelX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accelY => $composableBuilder(
      column: $table.accelY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accelZ => $composableBuilder(
      column: $table.accelZ, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get magnitude => $composableBuilder(
      column: $table.magnitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationDesc => $composableBuilder(
      column: $table.locationDesc, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationSent => $composableBuilder(
      column: $table.notificationSent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableOrderingComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accelX => $composableBuilder(
      column: $table.accelX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accelY => $composableBuilder(
      column: $table.accelY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accelZ => $composableBuilder(
      column: $table.accelZ, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get magnitude => $composableBuilder(
      column: $table.magnitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationDesc => $composableBuilder(
      column: $table.locationDesc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationSent => $composableBuilder(
      column: $table.notificationSent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncidentsTable> {
  $$IncidentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get accelX =>
      $composableBuilder(column: $table.accelX, builder: (column) => column);

  GeneratedColumn<double> get accelY =>
      $composableBuilder(column: $table.accelY, builder: (column) => column);

  GeneratedColumn<double> get accelZ =>
      $composableBuilder(column: $table.accelZ, builder: (column) => column);

  GeneratedColumn<double> get magnitude =>
      $composableBuilder(column: $table.magnitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get locationDesc => $composableBuilder(
      column: $table.locationDesc, builder: (column) => column);

  GeneratedColumn<bool> get notificationSent => $composableBuilder(
      column: $table.notificationSent, builder: (column) => column);

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncidentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncidentsTable,
    Incident,
    $$IncidentsTableFilterComposer,
    $$IncidentsTableOrderingComposer,
    $$IncidentsTableAnnotationComposer,
    $$IncidentsTableCreateCompanionBuilder,
    $$IncidentsTableUpdateCompanionBuilder,
    (Incident, $$IncidentsTableReferences),
    Incident,
    PrefetchHooks Function({bool userId})> {
  $$IncidentsTableTableManager(_$AppDatabase db, $IncidentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncidentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncidentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncidentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> accelX = const Value.absent(),
            Value<double> accelY = const Value.absent(),
            Value<double> accelZ = const Value.absent(),
            Value<double> magnitude = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> locationDesc = const Value.absent(),
            Value<bool> notificationSent = const Value.absent(),
            Value<DateTime> detectedAt = const Value.absent(),
          }) =>
              IncidentsCompanion(
            id: id,
            userId: userId,
            type: type,
            accelX: accelX,
            accelY: accelY,
            accelZ: accelZ,
            magnitude: magnitude,
            latitude: latitude,
            longitude: longitude,
            locationDesc: locationDesc,
            notificationSent: notificationSent,
            detectedAt: detectedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String type,
            required double accelX,
            required double accelY,
            required double accelZ,
            required double magnitude,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> locationDesc = const Value.absent(),
            Value<bool> notificationSent = const Value.absent(),
            Value<DateTime> detectedAt = const Value.absent(),
          }) =>
              IncidentsCompanion.insert(
            id: id,
            userId: userId,
            type: type,
            accelX: accelX,
            accelY: accelY,
            accelZ: accelZ,
            magnitude: magnitude,
            latitude: latitude,
            longitude: longitude,
            locationDesc: locationDesc,
            notificationSent: notificationSent,
            detectedAt: detectedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IncidentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                        $$IncidentsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$IncidentsTableReferences._userIdTable(db).id,
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

typedef $$IncidentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncidentsTable,
    Incident,
    $$IncidentsTableFilterComposer,
    $$IncidentsTableOrderingComposer,
    $$IncidentsTableAnnotationComposer,
    $$IncidentsTableCreateCompanionBuilder,
    $$IncidentsTableUpdateCompanionBuilder,
    (Incident, $$IncidentsTableReferences),
    Incident,
    PrefetchHooks Function({bool userId})>;
typedef $$GameScoresTableCreateCompanionBuilder = GameScoresCompanion Function({
  Value<int> id,
  required int userId,
  required int level,
  required int score,
  required int timeUsed,
  Value<bool> completed,
  Value<DateTime> playedAt,
});
typedef $$GameScoresTableUpdateCompanionBuilder = GameScoresCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<int> level,
  Value<int> score,
  Value<int> timeUsed,
  Value<bool> completed,
  Value<DateTime> playedAt,
});

final class $$GameScoresTableReferences
    extends BaseReferences<_$AppDatabase, $GameScoresTable, GameScore> {
  $$GameScoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.gameScores.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GameScoresTableFilterComposer
    extends Composer<_$AppDatabase, $GameScoresTable> {
  $$GameScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeUsed => $composableBuilder(
      column: $table.timeUsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GameScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $GameScoresTable> {
  $$GameScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeUsed => $composableBuilder(
      column: $table.timeUsed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GameScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameScoresTable> {
  $$GameScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get timeUsed =>
      $composableBuilder(column: $table.timeUsed, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GameScoresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GameScoresTable,
    GameScore,
    $$GameScoresTableFilterComposer,
    $$GameScoresTableOrderingComposer,
    $$GameScoresTableAnnotationComposer,
    $$GameScoresTableCreateCompanionBuilder,
    $$GameScoresTableUpdateCompanionBuilder,
    (GameScore, $$GameScoresTableReferences),
    GameScore,
    PrefetchHooks Function({bool userId})> {
  $$GameScoresTableTableManager(_$AppDatabase db, $GameScoresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameScoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> timeUsed = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
          }) =>
              GameScoresCompanion(
            id: id,
            userId: userId,
            level: level,
            score: score,
            timeUsed: timeUsed,
            completed: completed,
            playedAt: playedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required int level,
            required int score,
            required int timeUsed,
            Value<bool> completed = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
          }) =>
              GameScoresCompanion.insert(
            id: id,
            userId: userId,
            level: level,
            score: score,
            timeUsed: timeUsed,
            completed: completed,
            playedAt: playedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GameScoresTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                        $$GameScoresTableReferences._userIdTable(db),
                    referencedColumn:
                        $$GameScoresTableReferences._userIdTable(db).id,
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

typedef $$GameScoresTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GameScoresTable,
    GameScore,
    $$GameScoresTableFilterComposer,
    $$GameScoresTableOrderingComposer,
    $$GameScoresTableAnnotationComposer,
    $$GameScoresTableCreateCompanionBuilder,
    $$GameScoresTableUpdateCompanionBuilder,
    (GameScore, $$GameScoresTableReferences),
    GameScore,
    PrefetchHooks Function({bool userId})>;
typedef $$FeedbackEntriesTableCreateCompanionBuilder = FeedbackEntriesCompanion
    Function({
  Value<int> id,
  required int userId,
  required String subject,
  required String saran,
  required String kesan,
  required int rating,
  Value<DateTime> createdAt,
});
typedef $$FeedbackEntriesTableUpdateCompanionBuilder = FeedbackEntriesCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<String> subject,
  Value<String> saran,
  Value<String> kesan,
  Value<int> rating,
  Value<DateTime> createdAt,
});

final class $$FeedbackEntriesTableReferences extends BaseReferences<
    _$AppDatabase, $FeedbackEntriesTable, FeedbackEntry> {
  $$FeedbackEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.feedbackEntries.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FeedbackEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FeedbackEntriesTable> {
  $$FeedbackEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get saran => $composableBuilder(
      column: $table.saran, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kesan => $composableBuilder(
      column: $table.kesan, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedbackEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedbackEntriesTable> {
  $$FeedbackEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saran => $composableBuilder(
      column: $table.saran, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kesan => $composableBuilder(
      column: $table.kesan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedbackEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedbackEntriesTable> {
  $$FeedbackEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get saran =>
      $composableBuilder(column: $table.saran, builder: (column) => column);

  GeneratedColumn<String> get kesan =>
      $composableBuilder(column: $table.kesan, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeedbackEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedbackEntriesTable,
    FeedbackEntry,
    $$FeedbackEntriesTableFilterComposer,
    $$FeedbackEntriesTableOrderingComposer,
    $$FeedbackEntriesTableAnnotationComposer,
    $$FeedbackEntriesTableCreateCompanionBuilder,
    $$FeedbackEntriesTableUpdateCompanionBuilder,
    (FeedbackEntry, $$FeedbackEntriesTableReferences),
    FeedbackEntry,
    PrefetchHooks Function({bool userId})> {
  $$FeedbackEntriesTableTableManager(
      _$AppDatabase db, $FeedbackEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedbackEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedbackEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedbackEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> subject = const Value.absent(),
            Value<String> saran = const Value.absent(),
            Value<String> kesan = const Value.absent(),
            Value<int> rating = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedbackEntriesCompanion(
            id: id,
            userId: userId,
            subject: subject,
            saran: saran,
            kesan: kesan,
            rating: rating,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String subject,
            required String saran,
            required String kesan,
            required int rating,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedbackEntriesCompanion.insert(
            id: id,
            userId: userId,
            subject: subject,
            saran: saran,
            kesan: kesan,
            rating: rating,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeedbackEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                        $$FeedbackEntriesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$FeedbackEntriesTableReferences._userIdTable(db).id,
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

typedef $$FeedbackEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedbackEntriesTable,
    FeedbackEntry,
    $$FeedbackEntriesTableFilterComposer,
    $$FeedbackEntriesTableOrderingComposer,
    $$FeedbackEntriesTableAnnotationComposer,
    $$FeedbackEntriesTableCreateCompanionBuilder,
    $$FeedbackEntriesTableUpdateCompanionBuilder,
    (FeedbackEntry, $$FeedbackEntriesTableReferences),
    FeedbackEntry,
    PrefetchHooks Function({bool userId})>;
typedef $$FavoriteRoutesTableCreateCompanionBuilder = FavoriteRoutesCompanion
    Function({
  Value<int> id,
  required int userId,
  required String name,
  required String origin,
  required String destination,
  required String transportModes,
  Value<DateTime> savedAt,
});
typedef $$FavoriteRoutesTableUpdateCompanionBuilder = FavoriteRoutesCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<String> name,
  Value<String> origin,
  Value<String> destination,
  Value<String> transportModes,
  Value<DateTime> savedAt,
});

final class $$FavoriteRoutesTableReferences
    extends BaseReferences<_$AppDatabase, $FavoriteRoutesTable, FavoriteRoute> {
  $$FavoriteRoutesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.favoriteRoutes.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FavoriteRoutesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteRoutesTable> {
  $$FavoriteRoutesTableFilterComposer({
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

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transportModes => $composableBuilder(
      column: $table.transportModes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoriteRoutesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteRoutesTable> {
  $$FavoriteRoutesTableOrderingComposer({
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

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transportModes => $composableBuilder(
      column: $table.transportModes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoriteRoutesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteRoutesTable> {
  $$FavoriteRoutesTableAnnotationComposer({
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

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get destination => $composableBuilder(
      column: $table.destination, builder: (column) => column);

  GeneratedColumn<String> get transportModes => $composableBuilder(
      column: $table.transportModes, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoriteRoutesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoriteRoutesTable,
    FavoriteRoute,
    $$FavoriteRoutesTableFilterComposer,
    $$FavoriteRoutesTableOrderingComposer,
    $$FavoriteRoutesTableAnnotationComposer,
    $$FavoriteRoutesTableCreateCompanionBuilder,
    $$FavoriteRoutesTableUpdateCompanionBuilder,
    (FavoriteRoute, $$FavoriteRoutesTableReferences),
    FavoriteRoute,
    PrefetchHooks Function({bool userId})> {
  $$FavoriteRoutesTableTableManager(
      _$AppDatabase db, $FavoriteRoutesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteRoutesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteRoutesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteRoutesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> destination = const Value.absent(),
            Value<String> transportModes = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              FavoriteRoutesCompanion(
            id: id,
            userId: userId,
            name: name,
            origin: origin,
            destination: destination,
            transportModes: transportModes,
            savedAt: savedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String name,
            required String origin,
            required String destination,
            required String transportModes,
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              FavoriteRoutesCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            origin: origin,
            destination: destination,
            transportModes: transportModes,
            savedAt: savedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FavoriteRoutesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                        $$FavoriteRoutesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$FavoriteRoutesTableReferences._userIdTable(db).id,
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

typedef $$FavoriteRoutesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoriteRoutesTable,
    FavoriteRoute,
    $$FavoriteRoutesTableFilterComposer,
    $$FavoriteRoutesTableOrderingComposer,
    $$FavoriteRoutesTableAnnotationComposer,
    $$FavoriteRoutesTableCreateCompanionBuilder,
    $$FavoriteRoutesTableUpdateCompanionBuilder,
    (FavoriteRoute, $$FavoriteRoutesTableReferences),
    FavoriteRoute,
    PrefetchHooks Function({bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$CrowdReportsTableTableManager get crowdReports =>
      $$CrowdReportsTableTableManager(_db, _db.crowdReports);
  $$IncidentsTableTableManager get incidents =>
      $$IncidentsTableTableManager(_db, _db.incidents);
  $$GameScoresTableTableManager get gameScores =>
      $$GameScoresTableTableManager(_db, _db.gameScores);
  $$FeedbackEntriesTableTableManager get feedbackEntries =>
      $$FeedbackEntriesTableTableManager(_db, _db.feedbackEntries);
  $$FavoriteRoutesTableTableManager get favoriteRoutes =>
      $$FavoriteRoutesTableTableManager(_db, _db.favoriteRoutes);
}
