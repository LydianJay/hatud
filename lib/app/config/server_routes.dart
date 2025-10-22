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

  static const getRestaurants = Env.debug
      ? '${Env.serverURL}/hatud/public/api/restaurant/get_all'
      : '${Env.serverURL}/api/restaurant/get_all';

  static const getClientDetails = Env.debug
      ? '${Env.serverURL}/hatud/public/api/clients/get_client_details'
      : '${Env.serverURL}/api/clients/get_client_details';

  static const getResBasicDetails = Env.debug
      ? '${Env.serverURL}/hatud/public/api/restaurant/get_basic_details'
      : '${Env.serverURL}/api/restaurant/get_basic_details';

  static const getUser = Env.debug
      ? '${Env.serverURL}/hatud/public/api/user/get'
      : '${Env.serverURL}/api/user/get';
}
