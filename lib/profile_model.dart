import 'package:flutter/foundation.dart';

class ProfileModel extends ChangeNotifier {
  String _name = 'Demo User';
  String _email = 'demo@example.com';
  String _role = 'Guest';
  List<ClassModel> _classes = [];

  String get name => _name;
  String get email => _email;
  String get role => _role;
  List<ClassModel> get classes => _classes;

  void setProfile({required String name, required String email, required String role}) {
    _name = name;
    _email = email;
    _role = role;
    notifyListeners();
  }

  void addClass(ClassModel newClass) {
    _classes.add(newClass);
    notifyListeners();
  }

  void removeClass(String classId) {
    _classes.removeWhere((classItem) => classItem.id == classId);
    notifyListeners();
  }

  void clearProfile() {
    _name = 'Demo User';
    _email = 'demo@example.com';
    _role = 'Guest';
    _classes.clear();
    notifyListeners();
  }
}

// ✅ PASTIKAN MODEL KELAS DINAMAKAN ClassModel (BUKAN Class)
class ClassModel {
  final String id;
  final String name;
  final String code;
  final int questionCount;

  ClassModel({
    required this.id,
    required this.name,
    required this.code,
    this.questionCount = 0,
  });

  static List<ClassModel> getDemoClasses() {
    return [
      ClassModel(id: '1', name: 'Class 10A', code: 'ABC123', questionCount: 0),
      ClassModel(id: '2', name: 'Class 11B', code: 'XYZ789', questionCount: 0),
    ];
  }
}