import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return 'env.production';
    } else {
      return 'env.dev';
    }
  }

  static String get baseApiUrlV1 {
    return dotenv.env['BASEURL_V1'] ?? 'API BASE V1 URL NOT FOUND';
  }

  static String get frontSite {
    return dotenv.env['FONT_SITE'] ?? 'API BASE V1 URL NOT FOUND';
  }

  static String get baseApiUrl {
    return dotenv.env['BASEURL'] ?? 'API BASE V1 URL NOT FOUND';
  }

  static String get pusherKey {
    return dotenv.env['PUSHER_KEY'] ?? 'PUSHER KEY URL NOT FOUND';
  }

  static String get pusherCluster {
    return dotenv.env['PUSHER_CLUSTER'] ?? 'PUSHER CLUSTER NOT FOUND';
  }

  static String get pusherChannelName {
    return dotenv.env['PUSHER_CHANNEL_NAME'] ?? 'PUSHER CHANNEL NAME NOT FOUND';
  }
}
