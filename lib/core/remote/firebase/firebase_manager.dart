import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  static CollectionReference<UserModel> getUserCollection() {
    final collection = FirebaseFirestore.instance
        .collection("users")
        .withConverter(
          fromFirestore: (snapshot, _) =>
              UserModel.fromDocument(snapshot.data() ?? {}),
          toFirestore: (user, _) => user.toDocument(),
        );
    return collection;
  }

  static Future<void> addUser(String uid, UserModel user) {
    return getUserCollection().doc(uid).set(user);
  }

  static Future<UserModel?> getUser() {
    return getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data());
  }

  static CollectionReference<EventModel> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("events")
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventModel.fromDocument(snapshot.data() ?? {}),
          toFirestore: (event, _) => event.toDocument(),
        );
    return collection;
  }

  static Future<void> addEvent(EventModel event) {
    event.id = getEventCollection().doc().id;
    return getEventCollection().doc(event.id).set(event);
  }

  static Future<void> deleteEvent(String id) {
    return getEventCollection().doc(id).delete();
  }

  static Future<void> updateEvent(String id, EventModel event) {
    return getEventCollection().doc(id).set(event);
  }

  static Stream<List<EventModel>> getEvents() {
    return getEventCollection().snapshots().map(
      (value) => value.docs.map((e) => e.data()).toList(),
    );
  }

  static Stream<List<EventModel>> getEventsByType(String type) {
    return getEventCollection()
        .where("type", isEqualTo: type)
        .snapshots()
        .map((value) => value.docs.map((e) => e.data()).toList());
  }

  static CollectionReference<EventModel> getFavoriteCollection() {
    return getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventModel.fromDocument(snapshot.data() ?? {}),
          toFirestore: (event, _) => event.toDocument(),
        );
  }

  static Future<void> addToFavorite(EventModel event) async {
    await getFavoriteCollection().doc(event.id).set(event);
    await getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          "favorites": FieldValue.arrayUnion([event.id]),
        });
  }

  static Future<void> removeFromFavorite(EventModel event) async {
    await getFavoriteCollection().doc(event.id).delete();
    await getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          "favorites": FieldValue.arrayRemove([event.id]),
        });
  }

  static Stream<List<EventModel>> getFavoriteEvents() {
    return getFavoriteCollection().snapshots().map(
      (value) => value.docs.map((e) => e.data()).toList(),
    );
  }
}
