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
  final List<dynamic>? positions;
  final List<dynamic>? technologies;
  final List<dynamic>? userProjects;
}
