import '/config/providers.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Boot
|--------------------------------------------------------------------------
| The nylo method is called before the app is initialized.
| The finished method is called after the app is initialized.
|-------------------------------------------------------------------------- */

class Boot {
  static Future<Nylo> nylo() async {
    await _setup();
    return await bootApplication(providers);
  }

  static Future<void> finished(Nylo nylo) async =>
      await bootFinished(nylo, providers);
}

/* Setup
|--------------------------------------------------------------------------
| You can use _setup to initialize classes, variables, etc.
| It's run before your app providers are booted.
|-------------------------------------------------------------------------- */

_setup() async {
  /// Example: Initializing StorageConfig
  // StorageConfig.init(
  //   androidOptions: AndroidOptions(
  //     resetOnError: true,
  //     encryptedSharedPreferences: false
  //   )
  // );
}
