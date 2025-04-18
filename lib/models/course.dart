class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '', // Handle missing 'id' safely
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
    );
  }
}
