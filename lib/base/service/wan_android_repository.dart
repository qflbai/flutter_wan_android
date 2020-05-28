


import 'package:flutter_wan_android/base/net/wan_android_api.dart';
import 'package:flutter_wan_android/model/banner_entity.dart';

class WanAndroidRepository {


  static Future fetchBanners() async {
    var response = await http.get('banner/json');
    return response.data
        .map<Banner>((item) => Banner.fromJson(item))
        .toList();
  }


}
