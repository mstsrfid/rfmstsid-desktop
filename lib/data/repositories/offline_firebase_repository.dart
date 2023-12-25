import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OfflineFirebaseRepository<T extends FirebaseEntity>
    with FirebaseRepository<T> {
  OfflineFirebaseRepository(this._prefs) {
    void fireConnectionUpdate(ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          onConnectionChanged(_isOffline = false);
        case ConnectivityResult.none:
          onConnectionChanged(_isOffline = true);
        default:
          break;
      }
    }

    final conn = Connectivity();
    conn.checkConnectivity().then(fireConnectionUpdate);
    conn.onConnectivityChanged.listen(fireConnectionUpdate);
  }

  final SharedPreferences _prefs;
  String get prefsKey => collectionName;

  bool _isOffline = true;
  bool get isOffline => _isOffline;

  void onConnectionChanged(bool isOffline);

  List<T> getAllOffline() => (_prefs.getStringList(prefsKey) ?? [])
      .map((e) => decode(jsonDecode(e)))
      .toList();

  T? getOffline(String id) => getAllOffline()
      .cast<T?>()
      .firstWhere((e) => e!.id == id, orElse: () => null);

  Future<List<T>> getAllMaybeOffline() async {
    if (_isOffline) {
      return getAllOffline();
    }

    final data = await getAll();
    for (final e in data) {
      await setOffline(e);
    }
    return data;
  }

  Future<T?> getMaybeOffline(String id) async {
    if (_isOffline) {
      return getOffline(id);
    }

    final data = await get(id);
    if (data != null) {
      await setOffline(data);
    }
    return data;
  }

  Future<void> setOffline(T data) {
    final offlineData = getAllOffline();

    final i = offlineData.indexWhere((e) => e.id == data.id);
    if (i == -1) {
      offlineData.add(data);
    } else {
      offlineData[i] = data;
    }

    return _prefs.setStringList(
      prefsKey,
      offlineData.map((e) => jsonEncode(encode(e))).toList(),
    );
  }

  Future<void> setMaybeOffline(T data) async {
    await setOffline(data);

    if (!_isOffline) {
      await set(data);
    }
  }
}
