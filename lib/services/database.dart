import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Brew list from Snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0,
      );
    }).toList();
  }

  // UserData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  // Get brews Stream:
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // Get user Document Stream:
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
