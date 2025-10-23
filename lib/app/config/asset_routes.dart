import 'env.dart';

class AssetRoutes {
  static const itemImagesRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/upload/restaurant/img/'
      : '${Env.serverURL}/storage/upload/restaurant/img/';

  static const itemThumbRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/upload/restaurant/thumb/'
      : '${Env.serverURL}/storage/upload/restaurant/thumb/';

  static const resThumbRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/images/restaurant/resthumb/'
      : '${Env.serverURL}/storage/images/restaurant/resthumb/';

  static const userProfile = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/users/avatar/'
      : '${Env.serverURL}/storage/users/avatar/'; 
}
