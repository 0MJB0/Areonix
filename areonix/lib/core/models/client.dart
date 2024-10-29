import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable with IdModel, BaseFirebaseModel<Client> {
  final String? dietician;
  final String? mail;
  final String? name;
  final String? password;
  final String? surname;
  @override
  final String? id;
  final Map<String, Map<String, List<String>>>? diet;
  final Map<String, bool>? isFormSubmitted;
  final Map<String, Map<String, String>>? responses;
  final Map<String, String>? dailyReport;
  final Map<String, List<String>>? dieticianForms;
  final Map<String, Map<String, bool>>? dailyReportSubmitted;
  final String? dailyDeletedTime;

  Client({
    this.dietician,
    this.mail,
    this.name,
    this.password,
    this.surname,
    this.id,
    this.diet,
    this.isFormSubmitted,
    this.responses,
    this.dailyReport,
    this.dieticianForms,
    this.dailyReportSubmitted,
    this.dailyDeletedTime,
  });

  @override
  List<Object?> get props => [
        dietician,
        mail,
        name,
        password,
        surname,
        id,
        diet,
        isFormSubmitted,
        responses,
        dailyReport,
        dieticianForms,
        dailyReportSubmitted,
        dailyDeletedTime,
      ];

  Client copyWith({
    String? dietician,
    String? mail,
    String? name,
    String? password,
    String? surname,
    String? id,
    Map<String, Map<String, List<String>>>? diet,
    Map<String, bool>? isFormSubmitted,
    Map<String, Map<String, String>>? responses,
    Map<String, String>? dailyReport,
    Map<String, List<String>>? dieticianForms,
    Map<String, Map<String, bool>>? dailyReportSubmitted,
    String? dailyDeletedTime, // Yeni eklenen alan
  }) {
    return Client(
      dietician: dietician ?? this.dietician,
      mail: mail ?? this.mail,
      name: name ?? this.name,
      password: password ?? this.password,
      surname: surname ?? this.surname,
      id: id ?? this.id,
      diet: diet ?? this.diet,
      isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
      responses: responses ?? this.responses,
      dailyReport: dailyReport ?? this.dailyReport,
      dieticianForms: dieticianForms ?? this.dieticianForms,
      dailyReportSubmitted: dailyReportSubmitted ?? this.dailyReportSubmitted,
      dailyDeletedTime: dailyDeletedTime ?? this.dailyDeletedTime,
    );
  }

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'dietician': dietician,
      'mail': mail,
      'name': name,
      'password': password,
      'surname': surname,
      'id': id,
      'diet': diet,
      'isFormSubmitted': isFormSubmitted,
      'responses': responses
          ?.map((key, value) => MapEntry(key, Map<String, String>.from(value))),
      'daily_report': dailyReport,
      'dietician_forms': dieticianForms,
      'daily_report_submitted': dailyReportSubmitted?.map(
          (outerKey, innerMap) => MapEntry(outerKey,
              innerMap.map((innerKey, value) => MapEntry(innerKey, value)))),
      'daily_deleted_time': dailyDeletedTime,
    };
  }

  // JSON'dan Client modeline dönüştürme
  @override
  Client fromJson(Map<String, dynamic> json) {
    return Client(
      dietician: json['dietician'] as String?,
      mail: json['mail'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      surname: json['surname'] as String?,
      id: json['id'] as String?,
      diet: (json['diet'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as Map<String, dynamic>).map(
            (mealKey, mealValue) =>
                MapEntry(mealKey, List<String>.from(mealValue as List)),
          ),
        ),
      ),
      isFormSubmitted: (json['isFormSubmitted'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as bool),
      ),
      responses: (json['responses'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, Map<String, String>.from(value as Map)),
      ),
      dailyReport: (json['daily_report'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as String),
      ),
      dieticianForms: (json['dietician_forms'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, List<String>.from(value as List)),
      ),
      dailyReportSubmitted:
          (json['daily_report_submitted'] as Map<String, dynamic>?)?.map(
        (outerKey, innerMap) => MapEntry(
          outerKey,
          (innerMap as Map<String, dynamic>).map(
            (innerKey, value) => MapEntry(innerKey, value as bool),
          ),
        ),
      ),
      dailyDeletedTime: json['daily_deleted_time'] as String?,
    );
  }
}
