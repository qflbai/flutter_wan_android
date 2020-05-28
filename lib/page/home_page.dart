import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wan_android/base/state/view_state.dart';
import 'package:flutter_wan_android/base/view/base_view.dart';
import 'package:flutter_wan_android/view_modle/home_view_modle.dart';
import 'package:flutter_wan_android/widget/article_skeleton.dart';
import 'package:flutter_wan_android/widget/banner_image.dart';
import 'package:flutter_wan_android/widget/skeleton.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<HomeViewModle>(
        model: HomeViewModle(),
        onReady: (homeViewModle) {
          homeViewModle.initData();
        },
        builder: (context, homeViewModle, child) {
          return Scaffold(
            body: MediaQuery.removePadding(
                context: context,
                removeTop: false,
                child: Builder(builder: (_) {
                  return SmartRefresher(
                    controller: homeViewModle.refreshController,
                    enablePullDown: false,
                    enablePullUp: homeViewModle.loadOk,

                    child: CustomScrollView(

                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: false,
                          floating: false,

                          flexibleSpace: FlexibleSpaceBar(
                            title: const Text('Demo'),
                            background: Image.asset(
                              "./images/avatar.png", fit: BoxFit.cover,),
                          ),
                        ),

                        SliverToBoxAdapter(

                          child: BannerWidget(),
                        ),

                        if(homeViewModle.loading)
                          SliverToBoxAdapter(
                              child: SkeletonList(
                                builder: (context, index) =>
                                    ArticleSkeletonItem(),
                              )
                          ),

                        if(homeViewModle.loadOk)
                          SliverList(
                            delegate: new SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  var banners = homeViewModle.banners;
                                  //创建列表项
                                  return Material(
                                    child: InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                              bottom: Divider.createBorderSide(
                                                  context, width: 0.7),
                                            )
                                        ),

                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                KuangWidget(text:'置顶') ,
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(6.0,0.0,6.0,0.0),
                                                  child:  KuangWidget(text:'新') ,
                                                )
                                               ,
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                child: Text("ddd"),
                                              ),

                                              Expanded(
                                                child: SizedBox.shrink(),
                                              ),
                                              Text("dddddd"),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: 50 //50个列表项
                            ),
                          ),


                      ],
                    ),
                  );
                })),
          );
        });
  }
}

class KuangWidget extends StatelessWidget {
  final String text;
  KuangWidget({Key key,this.text}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: Colors.red[500]),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: Text(text),

    );
  }

}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: 200,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      child: Consumer<HomeViewModle>(builder: (_, homeModel, __) {
        if (homeModel.viewState == ViewState.loading) {
          return CupertinoActivityIndicator();
        } else {
          var banners = homeModel?.banners ?? [];
          return Swiper(
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            pagination: SwiperPagination(),
            itemCount: banners.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                  onTap: () {
                    var banner = banners[index];
                    /*Navigator.of(context).pushNamed(RouteName.articleDetail,
                        arguments: Article()
                          ..id = banner.id
                          ..title = banner.title
                          ..link = banner.url
                          ..collect = false);*/
                  },
                  child: BannerImage(banners[index].imagePath));
            },
          );
        }
      }),
    );
  }
}
