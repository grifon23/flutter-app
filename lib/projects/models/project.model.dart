class ProjectModel {
  final int id;
  final String? imageUrl;
  final String name;

  ProjectModel({
    required this.id,
    this.imageUrl,
    required this.name,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }
}
