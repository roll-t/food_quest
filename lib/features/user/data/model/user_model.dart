class UserModel {
  final String? uid;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? username;
  final String? role;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? security;
  final Map<String, dynamic>? settings;
  final String? password; // chỉ dùng khi login/register

  const UserModel({
    this.uid,
    this.displayName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.username,
    this.role = "admin",
    this.status = "active",
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.security,
    this.settings,
    this.password,
  });

  /// ✅ Factory cho login
  factory UserModel.login({
    required String username,
    required String password,
  }) {
    return UserModel(
      uid: '',
      displayName: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      username: username,
      role: '',
      status: '',
      password: password,
    );
  }

  /// ✅ Factory cho create/register
  factory UserModel.create({
    required String username,
    required String password,
    String displayName = '',
    String firstName = '',
    String lastName = '',
    String phoneNumber = '',
  }) {
    return UserModel(
      uid: '',
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      username: username,
      role: '',
      status: '',
      password: password,
    );
  }

  /// ✅ Factory fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'] ?? '',
      displayName: json['displayName'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.tryParse(json['lastLoginAt'])
          : null,
      security: json['security'] as Map<String, dynamic>?,
      settings: json['settings'] as Map<String, dynamic>?,
    );
  }

  /// ✅ Chuyển về JSON cơ bản (dùng khi debug)
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'username': username,
      'role': role,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'security': security,
      'settings': settings,
    };
  }

  /// ✅ Body cho request create/register
  Map<String, dynamic> toCreate() {
    return {
      'username': username,
      'password': password,
      'displayName': "${firstName?.trim()} ${lastName?.trim()}",
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  /// ✅ Body cho request login
  Map<String, dynamic> toLogin() {
    return {
      'username': username,
      'password': password,
    };
  }

  /// ✅ Request update profile
  Map<String, dynamic> toReq() {
    return {
      if ((displayName ?? '').isNotEmpty) 'displayName': displayName,
      if ((firstName ?? '').isNotEmpty) 'firstName': firstName,
      if ((lastName ?? '').isNotEmpty) 'lastName': lastName,
      if ((phoneNumber ?? '').isNotEmpty) 'phoneNumber': phoneNumber,
    };
  }

  /// ✅ Dùng để hiển thị dữ liệu (ví dụ trong UI)
  Map<String, dynamic> toResponse() {
    return {
      'id': uid,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'role': role,
      'status': status,
    };
  }

  /// ✅ Clone với dữ liệu mới
  UserModel toUpdateModel({
    String? displayName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username,
      role: role,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastLoginAt: lastLoginAt,
      security: security,
      settings: settings,
      password: password,
    );
  }

  bool isEqual(UserModel other) {
    return uid == other.uid &&
        displayName == other.displayName &&
        username == other.username &&
        role == other.role &&
        status == other.status;
  }

  UserModel clone() {
    return UserModel(
      uid: uid,
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      username: username,
      role: role,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastLoginAt: lastLoginAt,
      security: security,
      settings: settings,
      password: password,
    );
  }
}
