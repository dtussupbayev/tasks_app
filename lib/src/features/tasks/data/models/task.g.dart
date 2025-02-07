// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'isCompleted': instance.isCompleted,
    };
