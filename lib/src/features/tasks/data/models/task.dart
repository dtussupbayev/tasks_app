import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@immutable
@JsonSerializable()
class Task extends Equatable {
  Task({
    String? id,
    required this.title,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final bool isCompleted;

  Task copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object> get props => [id, title, isCompleted];
}
