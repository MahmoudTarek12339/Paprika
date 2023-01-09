import 'package:paprika/data/network/error_handler.dart';
import 'package:paprika/data/resonse/responses.dart';

const CACHE_FOR_YOU_KEY = "CACHE_FOR_YOU_KEY";
const CACHE_MASTER_CHEF_KEY = "CACHE_MASTER_CHEF_KEY";
const CACHE_STARTES_KEY = "CACHE_STARTES_KEY";
const CACHE_DINNER_KEY = "CACHE_DINNER_KEY";
const CACHE_SALAD_KEY = "CACHE_SALAD_KEY";
const CACHE_DESSERT_KEY = "CACHE_DESSERT_KEY";
const CACHE_HOME_INTERVAL = 300000;

abstract class LocalDataSource {
  Future<RandomRecipesResponse> getHomeData(String category);

  Future<void> saveHomeToCache(
      RandomRecipesResponse homeResponse, String category);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  //run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<RandomRecipesResponse> getHomeData(String category) async {
    CachedItem? cachedItem;
    switch (category) {
      case 'soup':
        cachedItem = cacheMap[CACHE_FOR_YOU_KEY];
        break;
      case 'lunch':
        cachedItem = cacheMap[CACHE_MASTER_CHEF_KEY];
        break;
      case 'starters':
        cachedItem = cacheMap[CACHE_STARTES_KEY];
        break;
      case 'dinner':
        cachedItem = cacheMap[CACHE_DINNER_KEY];
        break;
      case 'salad':
        cachedItem = cacheMap[CACHE_SALAD_KEY];
        break;
      case 'dessert':
        cachedItem = cacheMap[CACHE_DESSERT_KEY];
        break;
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
      RandomRecipesResponse homeResponse, String category) async {
    switch (category) {
      case 'soup':
        cacheMap[CACHE_FOR_YOU_KEY] = CachedItem(homeResponse);
        break;
      case 'lunch':
        cacheMap[CACHE_MASTER_CHEF_KEY] = CachedItem(homeResponse);
        break;
      case 'starters':
        cacheMap[CACHE_STARTES_KEY] = CachedItem(homeResponse);
        break;
      case 'dinner':
        cacheMap[CACHE_DINNER_KEY] = CachedItem(homeResponse);
        break;
      case 'salad':
        cacheMap[CACHE_SALAD_KEY] = CachedItem(homeResponse);
        break;
      case 'dessert':
        cacheMap[CACHE_DESSERT_KEY] = CachedItem(homeResponse);
        break;
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
