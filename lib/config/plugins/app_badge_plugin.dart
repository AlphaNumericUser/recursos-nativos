import 'package:flutter_app_badger/flutter_app_badger.dart';

// ! Este es mi patron adaptador
// ! Estos son metodos estaticos

class AppBadgePlugin{

  static Future<bool> get isBadgeSupported{
    return FlutterAppBadger.isAppBadgeSupported();
  }

  static void updateBadgeCout( int count ) async {
    if( !await isBadgeSupported ){
      print('Badge No Soportado');
      return;
    }

    FlutterAppBadger.updateBadgeCount( count );
    if( count == 0 ) removeBadge();
  }

  static void removeBadge() async {
    if( !await isBadgeSupported ){
      print('Badge No Soportado');
      return;
    }

    FlutterAppBadger.removeBadge();
  }

}