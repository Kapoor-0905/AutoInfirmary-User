// ignore_for_file: constant_identifier_names

enum ServerMode { local, live }

class ServerAddresses {
  static const String local = "http://localhost:3000";
  static const String live = "https://quickcare-m0hk.onrender.com";
}

// SERVER=13.202.26.147 ./abhideploy.sh
class ServerEndpoints {
  //Configurations
  static const ServerMode serverMode = ServerMode.local; //Change Mode Here

  //------------Server URL Getters---------------

  static const LOCALSERVER = ServerAddresses.local;
  static const LIVESERVER = ServerAddresses.live;

  //------------Server URL Getters---------------

  static String get currentServer {
    if (serverMode == ServerMode.live) {
      return LIVESERVER;
    } else if (serverMode == ServerMode.local) {
      return LOCALSERVER;
    }
    return LOCALSERVER;
  }

  static bool get isLive => serverMode == ServerMode.live;
}
