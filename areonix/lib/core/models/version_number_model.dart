import 'package:areonix/core/utility/base/base_firebase_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class VersionNumberModel extends Equatable
    with IdModel, BaseFirebaseModel<VersionNumberModel> {
  VersionNumberModel({
    this.number,
  });

  final String? number;
  @override
  String? id = '';

  VersionNumberModel copyWith({
    String? number,
  }) {
    return VersionNumberModel(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  VersionNumberModel fromJson(Map<String, dynamic> json) {
    return VersionNumberModel(
      number: json['number'] as String?,
    );
  }

  @override
  List<Object?> get props => [number];
}
