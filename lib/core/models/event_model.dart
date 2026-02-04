import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? type;
  String? time;
  Timestamp? date;
  EventModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.type,
    this.time,
    this.date,
  });

  EventModel.fromDocument(Map<String, dynamic> doc) {
    id = doc['id'] ?? "";
    userId = doc['userId'] ?? "";
    title = doc['title'] ?? "";
    description = doc['description'] ?? "";
    type = doc['type'] ?? "";
    time = doc['time'] ?? "";
    date = doc['date'] ?? Timestamp.now();
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'type': type,
      'time': time,
      'date': date,
    };
  }
}
