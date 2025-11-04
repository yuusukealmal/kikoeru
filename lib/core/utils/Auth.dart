// frb
import 'package:kikoeru/src/rust/api/requests/config/types.dart';

// core
import 'package:kikoeru/core/config/SharedPreferences.dart';

AuthHeader getAuthHeader() {
  return AuthHeader(
    token: SharedPreferencesHelper.getString("USER.TOKEN"),
    recommenderUuid: SharedPreferencesHelper.getString("USER.RECOMMENDER.UUID"),
    playlistId: SharedPreferencesHelper.getString("USER.PLAYLIST"),
  );
}
