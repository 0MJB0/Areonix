import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class Trainer extends Equatable with IdModel, BaseFirebaseModel<Trainer> {
  const Trainer({
    this.clientList,
    this.id,
    this.mail,
    this.name,
    this.password,
    this.totalDay,
    this.surname,
    this.registerDate,
    this.finishDate,
    this.dieticianForms,
  });

  final List<String>? clientList;
  final String? mail;
  final String? name;
  final String? password;
  final int? totalDay;
  final String? surname;
  final String? registerDate;
  final String? finishDate;
  final Map<String, List<String>>? dieticianForms;
  @override
  final String? id;

  @override
  List<Object?> get props => [
        clientList,
        mail,
        name,
        password,
        totalDay,
        surname,
        registerDate,
        finishDate,
        dieticianForms,
        id,
      ];

  Trainer copyWith({
    List<String>? clientList,
    String? id,
    String? mail,
    String? name,
    String? password,
    int? totalDay,
    String? surname,
    String? registerDate,
    String? finishDate,
    Map<String, List<String>>? dieticianForms, // Updated type
  }) {
    return Trainer(
      clientList: clientList ?? this.clientList,
      id: id ?? this.id,
      mail: mail ?? this.mail,
      name: name ?? this.name,
      password: password ?? this.password,
      totalDay: totalDay ?? this.totalDay,
      surname: surname ?? this.surname,
      registerDate: registerDate ?? this.registerDate,
      finishDate: finishDate ?? this.finishDate,
      dieticianForms: dieticianForms ?? this.dieticianForms, // Updated type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_list': clientList,
      'id': id,
      'mail': mail,
      'name': name,
      'password': password,
      'surname': surname,
      'register_date': registerDate,
      'total_day': totalDay,
      'finish_date': finishDate,
      'dietician_forms': dieticianForms, // Directly map the dieticianForms
    };
  }

  @override
  Trainer fromJson(Map<String, dynamic> json) {
    return Trainer(
      clientList: (json['client_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['id'] as String?,
      mail: json['mail'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      totalDay: json['total_day'] as int?,
      surname: json['surname'] as String?,
      registerDate: json['register_date'] as String?,
      finishDate: json['finish_date'] as String?,
      dieticianForms: json['dietician_forms'] is Map<String, dynamic>
          ? (json['dietician_forms'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List<dynamic>).map((item) => item as String).toList(),
              ),
            )
          : null, // Updated parsing logic for dieticianForms
    );
  }

  @override
  String toString() {
    return 'Dietician(clientList: $clientList, id: $id, mail: $mail, name: $name, password: $password,totalDay: $totalDay, surname: $surname, registerDate: $registerDate , finishDate :$finishDate, dieticianForms: $dieticianForms)';
  }
}
