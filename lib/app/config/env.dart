class Env {
  static const debug = bool.fromEnvironment('debug', defaultValue: true);
  static const debugURL = "http://192.168.1.52";
  static const liveURL = "https://hatudsiargao.com";

  static const serverURL = debug ? debugURL : liveURL;
}
