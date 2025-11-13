import 'package:flutter/material.dart';

// 1. Model cho Note
class Note {
  final String id;
  String title;
  String content;
  final DateTime dateCreated;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
  });
}

// 2. ChangeNotifier: Quản lý trạng thái và thông báo thay đổi
class NoteProvider extends ChangeNotifier {
  // Danh sách ghi chú (dữ liệu chính)
  final List<Note> _notes = [
    Note(
      id: DateTime.now().toString() + '1',
      title: 'Kế hoạch học Flutter',
      content:
          'Hoàn thành Project 5 (Note App) sử dụng Provider trong tuần này.',
      dateCreated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Note(
      id: DateTime.now().toString() + '2',
      title: 'Ý tưởng Project mới',
      content:
          'Tạo ứng dụng thời tiết đơn giản kết nối với API (Dự án tiếp theo?).',
      dateCreated: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  // Getter để truy cập danh sách Note từ bên ngoài
  List<Note> get notes => _notes;

  // Phương thức THÊM Note
  void addNote(String title, String content) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      dateCreated: DateTime.now(),
    );
    _notes.add(newNote);
    // Thông báo cho tất cả các widget đang lắng nghe về sự thay đổi
    notifyListeners();
  }

  // Phương thức SỬA Note
  void updateNote(Note note, String newTitle, String newContent) {
    note.title = newTitle;
    note.content = newContent;
    notifyListeners();
  }

  // Phương thức XÓA Note
  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
