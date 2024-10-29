import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class ClientResponse extends Equatable
    with IdModel, BaseFirebaseModel<ClientResponse> {
  const ClientResponse({
    this.id,
    this.responses,
    this.formSended,
  });

  @override
  final String? id;
  final bool? formSended;
  final List<Map<String, String>>? responses;

  @override
  List<Object?> get props => [id, responses, formSended];

  ClientResponse copyWith({
    String? id,
    List<Map<String, String>>? responses,
    bool? formSended,
  }) {
    return ClientResponse(
        id: id ?? this.id,
        responses: responses ?? this.responses,
        formSended: formSended ?? this.formSended);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'responses': responses,
      'formSended': formSended,
    };
  }

  @override
  ClientResponse fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      id: json['id'] as String?,
      formSended: json['formSended'] as bool?,
      responses: (json['responses'] as List<dynamic>?)
          ?.map((item) => Map<String, String>.from(item as Map))
          .toList(),
    );
  }
}
