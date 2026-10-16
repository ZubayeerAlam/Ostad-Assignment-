import 'package:flutter/foundation.dart';

import '../models/student.dart';

class AttendanceProvider extends ChangeNotifier {
  final List<Student> _students = [];

  List<Student> get students => List.unmodifiable(_students);

  int get totalStudents => _students.length;
  int get presentCount => _students.where((s) => s.isPresent).length;
  int get absentCount => totalStudents - presentCount;

  void addStudent(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    _students.add(
      Student(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: trimmed,
      ),
    );
    notifyListeners();
  }

  void toggleAttendance(String id, bool isPresent) {
    final student = _students.firstWhere((s) => s.id == id);
    student.isPresent = isPresent;
    notifyListeners();
  }

  void removeStudent(String id) {
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
