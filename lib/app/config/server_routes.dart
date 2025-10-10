import 'env.dart';

class ServerRoutes {
  static const loginRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/api/mobile/login'
      : '${Env.serverURL}/api/mobile/login';

  static const registerRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/api/mobile/create'
      : '${Env.serverURL}/api/mobile/create';

  static const getPopularItems = Env.debug
      ? '${Env.serverURL}/hatud/public/api/items/get_popular'
      : '${Env.serverURL}/api/items/get_popular';


  
}
