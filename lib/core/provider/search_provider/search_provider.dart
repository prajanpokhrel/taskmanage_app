import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanagement_app/features/search/data/model/task_search_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];

  List<Task> get filteredTasks => _filteredTasks;

  Future<void> fetchTasks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('tasks')
            .where('creator', isEqualTo: uid)
            .get();

    _allTasks =
        snapshot.docs.map((doc) => Task.fromMap(doc.data(), doc.id)).toList();

    _filteredTasks = _allTasks;
    notifyListeners();
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      _filteredTasks = _allTasks;
    } else {
      _filteredTasks =
          _allTasks.where((task) {
            return task.title.toLowerCase().contains(query.toLowerCase());
          }).toList();
    }
    notifyListeners();
  }
}
