import 'env.dart';

class AssetRoutes {
  static const itemImagesRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/upload/restaurant/img/'
      : '${Env.serverURL}/storage/upload/restaurant/img/';

  static const itemThumbRoute = Env.debug
      ? '${Env.serverURL}/hatud/public/storage/upload/restaurant/thumb/'
      : '${Env.serverURL}/storage/upload/restaurant/thumb/';
}
