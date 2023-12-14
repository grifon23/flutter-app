class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.lastName,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.cooperationStartDate,
    required this.birthDate,
    required this.role,
    required this.positions,
    required this.technologies,
    required this.userProjects,
  });

  final String name;
  final String email;
  final String lastName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? cooperationStartDate;
  final String? birthDate;
  final String? role;
  final String? positions;
  final List<dynamic>? technologies;
  final List<dynamic>? userProjects;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'lastName': lastName,
      'avatarUrl': avatarUrl,
      'phoneNumber': phoneNumber,
      'cooperationStartDate': cooperationStartDate,
      'birthDate': birthDate,
      'role': role,
      'positions': positions,
      'technologies': technologies,
      'userProjects': userProjects,
    };
  }
}
