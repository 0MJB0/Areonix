import 'package:equatable/equatable.dart';

class DieticianFormState extends Equatable {
  final String? formName;
  final List<String>? questions;

  const DieticianFormState({
    this.formName,
    this.questions,
  });

  DieticianFormState copyWith({
    String? formName,
    List<String>? questions,
  }) {
    return DieticianFormState(
      formName: formName ?? this.formName,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [formName, questions];
}

class FormListManagerState extends Equatable {
  const FormListManagerState({
    this.forms = const [],
    this.filteredForms,
    this.searchingForms = false,
  });
  final List<DieticianFormState> forms;
  final List<DieticianFormState>? filteredForms;
  final bool searchingForms;

  FormListManagerState copyWith({
    List<DieticianFormState>? forms,
    List<DieticianFormState>? filteredForms,
    bool? searchingForms,
  }) {
    return FormListManagerState(
      forms: forms ?? this.forms,
      filteredForms: filteredForms ?? this.filteredForms,
      searchingForms: searchingForms ?? this.searchingForms,
    );
  }

  @override
  List<Object?> get props => [forms, filteredForms, searchingForms];
}
