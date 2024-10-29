import 'package:equatable/equatable.dart';

class CardClientState extends Equatable {
  final String? clientId;
  final String? clientName;
  final String? clientSurname;
  const CardClientState({
    this.clientId,
    this.clientName,
    this.clientSurname,
  });

  @override
  List<Object?> get props => [
        clientId,
        clientName,
        clientSurname,
      ];
}

class CardClientListState extends Equatable {
  const CardClientListState({
    this.clients = const [],
    this.filteredClients,
    this.searchingClients = false,
    this.isFetchingClient = false,
  });
  final List<CardClientState> clients;
  final List<CardClientState>? filteredClients;
  final bool searchingClients;
  final bool isFetchingClient;

  CardClientListState copyWith({
    List<CardClientState>? clients,
    List<CardClientState>? filteredClients,
    bool? searchingClients,
    bool? isFetchingClient,
  }) {
    return CardClientListState(
      clients: clients ?? this.clients,
      filteredClients: filteredClients ?? this.filteredClients,
      searchingClients: searchingClients ?? this.searchingClients,
      isFetchingClient: isFetchingClient ?? this.isFetchingClient,
    );
  }

  @override
  List<Object?> get props =>
      [clients, filteredClients, searchingClients, isFetchingClient];
}
