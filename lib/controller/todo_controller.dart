import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/todo_model.dart';

GetStorage storage = GetStorage();

class TodoController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> readData() async {
    isLoading.value = true;
    //read data from storage
    String? storedData = storage.read('todos');
    if (storedData != null) {
      List<TodoModel> storedTodoList = todoModelFromJson(storedData);
      _todos.value = storedTodoList;
      update();
    }
    isLoading.value = false;
  }

  final RxList<TodoModel> _todos = <TodoModel>[].obs;

  RxList<TodoModel> get todos => _todos;

  RxList<TodoModel> get completedTodos {
    return [..._todos.where((element) => element.isCompleted == true).toList()]
        .obs;
  }

  RxList<TodoModel> get remainingTodos {
    return [..._todos.where((element) => element.isCompleted == false).toList()]
        .obs;
  }

  TodoModel getById(String id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  void addToStorage() {
    storage.write('todos', jsonEncode(_todos));
  }

  void add(TodoModel todo) async {
    //add data
    _todos.add(todo);
    addToStorage();
    update();
  }

  void updateTodo(TodoModel todo) async {
    TodoModel temp = _todos.firstWhere((element) => element.id == todo.id);
    temp.title = todo.title;
    addToStorage();
    //update data
    update();
  }

  void updateisCompleted(String id, bool value) async {
    TodoModel temp = _todos.firstWhere((element) => element.id == id);
    temp.isCompleted = value;
    addToStorage();
    update();
  }

  void delete(String id) async {
    _todos.removeWhere((element) => element.id == id);
    addToStorage();
    update();
  }

  int getCompletedTask() {
    int count = 0;
    for (var i = 0; i < _todos.length; i++) {
      if (_todos[i].isCompleted == true) {
        count++;
      }
    }
    return count;
  }
}
