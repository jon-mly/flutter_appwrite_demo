import 'package:appwrite_demo/models/classes/shared_preferences_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _sharedPreferencesProvider = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

final sharedPrefsDataProvider =
    StateNotifierProvider<SharedPreferencesDataNotifier, SharedPreferencesData?>(
        (ref) {
  final pref = ref
      .watch(_sharedPreferencesProvider)
      .maybeWhen(data: (prefs) => prefs, orElse: () => null);
  return SharedPreferencesDataNotifier(pref);
});

class SharedPreferencesDataNotifier
    extends StateNotifier<SharedPreferencesData?> {
  SharedPreferencesDataNotifier(SharedPreferences? pref)
      : _pref = pref,
        super(null) {
    _fetchAll();
  };

  final SharedPreferences? _pref;

  void _fetchAll() {
    if (_pref == null) {
      state = null;
      return;
    }
    state = SharedPreferencesData(
      activeAccountSessionId: _pref?.getString("active_account_session_id")
    );
  }

  // Improvements :
  // - Should move hard coded keys into a separated provider
  // -
}
