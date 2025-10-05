import 'env.dart';

class ServerRoutes {
  static const loginRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/api/mobile/login'
      : '${Env.serverURL}/mobile/login';

  static const registerRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/api/mobile/create'
      : '${Env.serverURL}/mobile/create';
}
