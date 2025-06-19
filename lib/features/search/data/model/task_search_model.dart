import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final Timestamp date;
  final String color;
  final String imageUrl;
  final String creator;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    required this.imageUrl,
    required this.creator,
  });

  factory Task.fromMap(Map<String, dynamic> data, String documentId) {
    return Task(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: data['date'],
      color: data['color'] ?? '#FFFFFF',
      imageUrl: data['imageUrl'],
      creator: data['creator'] ?? '',
    );
  }
}
