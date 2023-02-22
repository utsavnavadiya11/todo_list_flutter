// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) =>
    List<TodoModel>.from(json.decode(str)!.map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class TodoModel {
  TodoModel({
    this.id ="",
    this.title = '',
    this.isCompleted = false,
  });

  String id;
  String title;
  bool isCompleted;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        title: json["title"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isCompleted": isCompleted,
      };
}
