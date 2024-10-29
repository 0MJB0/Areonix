import 'package:equatable/equatable.dart';

class ClientState extends Equatable {
  final List<String>? currentDayMealTimes;
  final String? currentDay;
  final Map<String, List<String>>? mealDetails;
  final Map<String, Map<String, List<String>>>? diet;
  final String? clientID;
  final String? password;
  final String? clientName;
  final String? clientSurname;
  final String? clientMail;
  final bool isLoading;
  final String? dieticianID;
  final List<String>? questions;
  final Map<String, bool>? isFormSubmitted;
  final Map<String, Map<String, String>>? responses;
  final Map<String, String>? dailyReport;
  final List<String>? clientFiles;
  final Map<String, Map<String, bool>>? dailyReportSubmitted;
  final Map<String, List<String>>? dieticianForms;
  final String? currentFormTitle;
  final String? dailyDeletedTime;

  const ClientState(
      {this.currentDay,
      this.currentDayMealTimes,
      this.mealDetails,
      this.clientID,
      this.password,
      this.clientName,
      this.clientSurname,
      this.clientMail,
      this.isLoading = false,
      this.dieticianID,
      this.questions,
      this.isFormSubmitted,
      this.responses,
      this.dailyReport,
      this.clientFiles,
      this.dailyReportSubmitted,
      this.dieticianForms,
      this.currentFormTitle,
      this.dailyDeletedTime,
      this.diet});

  ClientState copyWith(
      {String? currentDay,
      Map<String, Map<String, List<String>>>? diet,
      List<String>? currentDayMealTimes,
      Map<String, List<String>>? mealDetails,
      String? clientID,
      String? password,
      String? clientName,
      String? clientSurname,
      String? clientMail,
      bool? isLoading,
      String? dieticianID,
      List<String>? questions,
      Map<String, bool>? isFormSubmitted,
      Map<String, Map<String, String>>? responses,
      Map<String, String>? dailyReport,
      List<String>? clientFiles,
      Map<String, Map<String, bool>>? dailyReportSubmitted,
      Map<String, List<String>>? dieticianForms,
      String? currentFormTitle,
      String? dailyDeletedTime}) {
    return ClientState(
        currentDay: currentDay ?? currentDay,
        diet: diet ?? this.diet,
        currentDayMealTimes: currentDayMealTimes ?? this.currentDayMealTimes,
        mealDetails: mealDetails ?? this.mealDetails,
        clientID: clientID ?? this.clientID,
        password: password ?? this.password,
        clientName: clientName ?? this.clientName,
        clientSurname: clientSurname ?? this.clientSurname,
        clientMail: clientMail ?? this.clientMail,
        isLoading: isLoading ?? this.isLoading,
        dieticianID: dieticianID ?? this.dieticianID,
        questions: questions ?? this.questions,
        isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
        responses: responses ?? this.responses,
        dailyReport: dailyReport ?? this.dailyReport,
        clientFiles: clientFiles ?? this.clientFiles,
        dailyReportSubmitted: dailyReportSubmitted ?? this.dailyReportSubmitted,
        dieticianForms: dieticianForms ?? this.dieticianForms,
        currentFormTitle: currentFormTitle ?? this.currentFormTitle,
        dailyDeletedTime: dailyDeletedTime ?? this.dailyDeletedTime);
  }

  @override
  List<Object?> get props => [
        currentDay,
        diet,
        currentDayMealTimes,
        mealDetails,
        clientID,
        password,
        clientName,
        clientSurname,
        clientMail,
        isLoading,
        dieticianID,
        questions,
        isFormSubmitted,
        responses,
        dailyReport,
        clientFiles,
        dailyReportSubmitted,
        dieticianForms,
        currentFormTitle,
        dailyDeletedTime
      ];
}
