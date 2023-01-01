import 'package:paprika/data/network/error_handler.dart';
import 'package:paprika/data/resonse/responses.dart';

const CACHE_FOR_YOU_KEY = "CACHE_FOR_YOU_KEY";
const CACHE_MASTER_CHEF_KEY = "CACHE_MASTER_CHEF_KEY";
const CACHE_HOME_INTERVAL = 300000;

abstract class LocalDataSource {
  Future<RandomRecipesResponse> getHomeData(bool forYou);

  Future<void> saveHomeToCache(RandomRecipesResponse homeResponse, bool forYou);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  //run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<RandomRecipesResponse> getHomeData(bool forYou) async {
    CachedItem? cachedItem;
    if (forYou) {
      cachedItem = cacheMap[CACHE_FOR_YOU_KEY];
    } else {
      cachedItem = cacheMap[CACHE_MASTER_CHEF_KEY];
    }
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      //return response
      return cachedItem.data;
    } else {
      //throw error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(
      RandomRecipesResponse homeResponse, bool forYou) async {
    if (forYou) {
      cacheMap[CACHE_FOR_YOU_KEY] = CachedItem(homeResponse);
    } else {
      cacheMap[CACHE_MASTER_CHEF_KEY] = CachedItem(homeResponse);
    }
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
