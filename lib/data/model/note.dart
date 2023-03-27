class Note {
  Note({this.id, required this.title, required this.description});

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
  }

  late int? id;
  late String title;
  late String description;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
