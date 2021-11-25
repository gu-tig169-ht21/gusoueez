// ignore_for_file: file_names

class Items {
  final String id;
  final String title;
  final bool done;

  const Items({required this.id, required this.title, required this.done});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }
}
