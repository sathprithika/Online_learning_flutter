import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  String uid;
  String userName;
  String email;
  List<String> enrolledCourses;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.enrolledCourses,
  });

  // Setter method for userName
  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  // Method to enroll in a course
  void enrollCourse(String courseName) {
    if (!enrolledCourses.contains(courseName)) {
      enrolledCourses.add(courseName);
      notifyListeners();
    }
  }

  // Factory method to create from map (optional)
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      enrolledCourses: List<String>.from(data['enrolledCourses'] ?? []),
    );
  }

  // Convert to map (optional)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'enrolledCourses': enrolledCourses,
    };
  }
}
