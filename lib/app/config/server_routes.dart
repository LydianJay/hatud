import 'env.dart';

class ServerRoutes {
  static const loginRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/api/mobile/login'
      : '${Env.serverURL}/mobile/login';
}
