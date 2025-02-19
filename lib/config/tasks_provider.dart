import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dandaily/app/models/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TasksProvider extends ChangeNotifier {
  Stream<List<Todo>> getUserTodos() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection("Todos")
        .doc(user.uid)
        .collection("userTodos")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Todo.fromMap(doc.data())).toList());
  }
}
