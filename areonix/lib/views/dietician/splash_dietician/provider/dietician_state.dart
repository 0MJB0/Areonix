import 'package:equatable/equatable.dart';

class DieticianState extends Equatable {
  final List<String>? clientList;
  final String? mail;
  final String? name;
  final String? password;
  final int? totalDay;
  final String? surname;
  final String? registerDate;
  final String? finishDate;
  final Map<String, List<String>>? dieticianForms;
  final String? id;
  final bool isLoading;
  final Map<String, Map<String, String>>?
      fileUrlToDateMealMap; // Tüm client'lerin dosyaları

  const DieticianState({
    this.clientList,
    this.mail,
    this.name,
    this.password,
    this.totalDay,
    this.surname,
    this.registerDate,
    this.finishDate,
    this.dieticianForms,
    this.id,
    this.isLoading = false,
    this.fileUrlToDateMealMap, // Yeni alan
  });

  DieticianState copyWith({
    List<String>? clientList,
    String? mail,
    String? name,
    String? password,
    int? totalDay,
    String? surname,
    String? registerDate,
    String? finishDate,
    Map<String, List<String>>? dieticianForms,
    String? id,
    bool? isLoading,
    Map<String, Map<String, String>>?
        fileUrlToDateMealMap, // Yeni alan copyWith'te eklendi
  }) {
    return DieticianState(
      clientList: clientList ?? this.clientList,
      mail: mail ?? this.mail,
      name: name ?? this.name,
      password: password ?? this.password,
      totalDay: totalDay ?? this.totalDay,
      surname: surname ?? this.surname,
      registerDate: registerDate ?? this.registerDate,
      finishDate: finishDate ?? this.finishDate,
      dieticianForms: dieticianForms ?? this.dieticianForms,
      id: id ?? this.id,
      isLoading: isLoading ?? this.isLoading,
      fileUrlToDateMealMap:
          fileUrlToDateMealMap ?? this.fileUrlToDateMealMap, // Yeni alan
    );
  }

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
        isLoading,
        fileUrlToDateMealMap, // Yeni alan
      ];
}
