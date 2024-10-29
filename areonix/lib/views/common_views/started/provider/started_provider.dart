import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/core/utility/version_manager/version_manager.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'started_state.dart';

class StartedNotifier extends StateNotifier<StartedState> {
  StartedNotifier() : super(StartedState());

  Future<void> checkVersionWithCheckInternetConnnection(
    String clientVersion,
  ) async {
    try {
      final databaseValue = await getVersionNumberFromDatabase();

      if (databaseValue == null || databaseValue.isEmpty) {
        state = state.copyWith(isRedirectHome: false);
        state = state.copyWith(isConnectedInternet: false);
        return;
      }

      final versionManager = VersionManager(
        deviceValue: clientVersion,
        databaseValue: databaseValue,
      );

      if (versionManager.isNeedUpdate()) {
        state = state.copyWith(isRequiredForceUpdate: true);
        return;
      }

      state = state.copyWith(isRedirectHome: true);
      state = state.copyWith(isConnectedInternet: true);
    } catch (e) {
      state = state.copyWith(isRedirectHome: false);
    }
  }

  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) return null;

    final response = await FirebaseCollections.version.reference
        .withConverter<VersionNumberModel>(
          fromFirestore: (snapshot, options) =>
              VersionNumberModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnum.versionName)
        .get();

    return response.data()?.number;
  }
}

final startedProvider = StateNotifierProvider<StartedNotifier, StartedState>(
  (ref) => StartedNotifier(),
);
