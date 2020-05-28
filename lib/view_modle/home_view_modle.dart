import 'package:flutter_wan_android/base/service/wan_android_repository.dart';
import 'package:flutter_wan_android/base/state/view_state.dart';
import 'package:flutter_wan_android/base/view_modle/base_view_model.dart';
import 'package:flutter_wan_android/base/view_modle/list_view_model.dart';
import 'package:flutter_wan_android/base/view_modle/view_state_refresh_list_model.dart';
import 'package:flutter_wan_android/model/banner_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewModle extends ViewStateRefreshListModel {
  List<Banner> _banners;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;


  List<Banner> get banners => _banners;

  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == 0) {
      futures.add(WanAndroidRepository.fetchBanners());
    }
    // futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == 0) {
      _banners = result[0];

      return result[0];
    } else {
      return result;
    }
  }

  @override
  onCompleted(List data) {

  }
}
