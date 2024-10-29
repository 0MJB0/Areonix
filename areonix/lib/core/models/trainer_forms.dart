import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class TrainerForms extends Equatable
    with IdModel, BaseFirebaseModel<TrainerForms> {
  const TrainerForms({
    this.id,
    this.questions,
    this.form_name,
  });

  @override
  final String? id;
  final String? form_name;
  final List<String>? questions;

  @override
  List<Object?> get props => [id, questions, form_name];

  TrainerForms copyWith({
    String? id,
    List<String>? questions,
    String? form_name,
  }) {
    return TrainerForms(
        id: id ?? this.id,
        questions: questions ?? this.questions,
        form_name: form_name ?? this.form_name);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions,
      'form_name': form_name,
    };
  }

  @override
  TrainerForms fromJson(Map<String, dynamic> json) {
    return TrainerForms(
      id: json['id'] as String?,
      form_name: json['form_name'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
    );
  }
}
