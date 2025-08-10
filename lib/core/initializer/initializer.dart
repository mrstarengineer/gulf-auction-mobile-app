import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/core/core.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gulf_car_auction/core/dependencies/initial_dependencies.dart' as dependencies;

abstract class Initializer {
  Initializer._();

  static void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return AppErrorWidget(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        Get.printInfo(info: details.stack.toString());
      };

      await _initServices();

      runApp();
    }, (error, stack) {
      Get.printInfo(info: 'runZonedGuarded: ${error.toString()}');
    });
  }

  static Future<void> _initServices() async {
    try {

      _initScreenPreference();

      _initHttp();

      await _initStorage();

      await _initPusher();
      await _initAudioPlayer();

      await _loadEnv();

      await _dependencyInjection();




    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initPusher() async {
    final pusher = PusherChannelsFlutter.getInstance();
    Get.lazyPut(() => pusher, fenix: true);
  }

  static Future<void> _initStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences, fenix: true);
  }

  static Future<void> _initAudioPlayer() async {
    final audioPlayer = AudioPlayer();
    Get.lazyPut(() => audioPlayer, fenix: true);
  }

  static void _initHttp (){
    HttpOverrides.global = MyHttpOverrides();
  }

  static Future<void> _dependencyInjection () async{
    await dependencies.init();
  }

  static Future<void> _loadEnv () async{
    await dotenv.load(fileName: Environment.fileName);
  }



  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}