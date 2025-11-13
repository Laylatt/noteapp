import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/note_provider.dart';

void main() {
  // Khởi tạo Provider ở cấp cao nhất của ứng dụng
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const NoteApp(),
    ),
  );
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App (Provider)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const NotesListScreen(),
    );
  }
}

// --------------------------------------------------------------------------
// MÀN HÌNH DANH SÁCH NOTES
// --------------------------------------------------------------------------
class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Sử dụng Consumer để lắng nghe sự thay đổi của danh sách ghi chú
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        final notes = noteProvider.notes;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Notes (Provider State)'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          body: notes.isEmpty
              ? const Center(
                  child: Text(
                    'Không có ghi chú nào. Hãy thêm ghi chú mới!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(note: note, noteProvider: noteProvider);
                  },
                ),
          // FloatingActionButton để thêm ghi chú
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const EditNoteScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

// --------------------------------------------------------------------------
// WIDGET CARD GHI CHÚ
// --------------------------------------------------------------------------
class NoteCard extends StatelessWidget {
  final Note note;
  final NoteProvider noteProvider;

  const NoteCard({required this.note, required this.noteProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 2,
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Xác nhận trước khi xóa
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: const Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () {
                      noteProvider.deleteNote(note.id);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      'Xóa',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        onTap: () {
          // Chuyển sang màn hình Edit
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => EditNoteScreen(note: note)),
          );
        },
      ),
    );
  }
}

// --------------------------------------------------------------------------
// MÀN HÌNH THÊM/SỬA NOTES
// --------------------------------------------------------------------------
class EditNoteScreen extends StatefulWidget {
  final Note? note; // Note có thể null (nếu là thêm mới)

  const EditNoteScreen({this.note, super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Nếu là chế độ sửa (edit), điền dữ liệu cũ vào TextField
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    // listen: false là bắt buộc khi gọi phương thức của Provider trong sự kiện (onPressed, _saveNote)
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    if (_titleController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tiêu đề và nội dung không được để trống!'),
        ),
      );
      return;
    }

    if (widget.note == null) {
      // THÊM MỚI
      noteProvider.addNote(_titleController.text, _contentController.text);
    } else {
      // SỬA
      noteProvider.updateNote(
        widget.note!,
        _titleController.text,
        _contentController.text,
      );
    }

    Navigator.of(context).pop(); // Quay lại màn hình danh sách
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Sửa Ghi Chú' : 'Thêm Ghi Chú'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // TextField Tiêu đề
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tiêu đề',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // TextField Nội dung
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Nội dung',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 15, // Cho phép nhập nhiều dòng
              minLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
