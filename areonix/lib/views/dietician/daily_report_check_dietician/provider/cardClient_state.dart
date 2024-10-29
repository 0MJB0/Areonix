import 'package:equatable/equatable.dart';

class DailyReportCardState extends Equatable {
  final String? clientId;
  final String? clientName;
  final String? clientSurname;

  const DailyReportCardState({
    this.clientId,
    this.clientName,
    this.clientSurname,
  });

  @override
  List<Object?> get props => [clientId, clientName, clientSurname];
}

class DailyReportListState extends Equatable {
  final List<DailyReportCardState> clients;
  final List<DailyReportCardState>? filteredClients;
  final bool searchingClients;

  /// Tüm client'ların dosya bilgilerini saklayan alan.
  /// Her client için dosya bilgileri bir map içinde saklanır.
  /// Map<String, Map<String, String>> formatında olup:
  /// - Anahtar: Dosyanın `clientId`
  /// - İçerik: Bir alt map olup "date", "meal", ve "downloadUrl" içerir.
  final List<Map<String, String>>? allFiles;

  const DailyReportListState({
    this.clients = const [],
    this.filteredClients,
    this.searchingClients = false,
    this.allFiles, // Yeni alan
  });

  DailyReportListState copyWith({
    List<DailyReportCardState>? clients,
    List<DailyReportCardState>? filteredClients,
    bool? searchingClients,
    List<Map<String, String>>? allFiles, // Yeni alan copyWith'te eklendi
  }) {
    return DailyReportListState(
      clients: clients ?? this.clients,
      filteredClients: filteredClients ?? this.filteredClients,
      searchingClients: searchingClients ?? this.searchingClients,
      allFiles: allFiles ?? this.allFiles, // Yeni alan güncelleniyor
    );
  }

  @override
  List<Object?> get props => [
        clients,
        filteredClients,
        searchingClients,
        allFiles, // Yeni alan props'a eklendi
      ];
}
