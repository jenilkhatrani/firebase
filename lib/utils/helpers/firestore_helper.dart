import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/event_model.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addEventToFirestore(EventModel event) async {
    try {
      await firebaseFirestore.collection('events').add({
        'title': event.title,
        'date': event.date,
        'description': event.description,
      });
      print("Event added to Firestore");
    } catch (e) {
      print("Error adding event to Firestore: $e");
    }
  }

  Future<List<EventModel>> fetchEventsFromFirestore() async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('events').get();

    return querySnapshot.docs.map((doc) {
      return EventModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
