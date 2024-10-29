import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

class Pool extends Equatable with IdModel, BaseFirebaseModel<Pool> {
  final List<String>? appointedClients;
  final List<String>? dietician; // Yeni eklenen dietician alanı

  Pool({this.appointedClients, this.dietician, this.id});

  @override
  final String? id; // IdModel'den gelen id

  @override
  List<Object?> get props => [appointedClients, dietician, id];

  Pool copyWith(
      {List<String>? appointedClients, List<String>? dietician, String? id}) {
    return Pool(
      appointedClients: appointedClients ?? this.appointedClients,
      dietician: dietician ?? this.dietician,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointed_clients': appointedClients,
      'dietician':
          dietician, // Yeni eklenen dietician alanını da JSON'a ekleyin
      'id': id,
    };
  }

  @override
  Pool fromJson(Map<String, dynamic> json) {
    return Pool(
      appointedClients: json['appointed_clients'] != null
          ? List<String>.from(json['appointed_clients'] as List)
          : null,
      dietician: json['dietician'] != null
          ? List<String>.from(json['dietician'] as List)
          : null,
      id: json['id'] as String?,
    );
  }
}
