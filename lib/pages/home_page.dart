import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widgets/grid_nav.dart';
import 'package:flutter_trip/widgets/local_nav.dart';

const double appbarScrollOffset = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> _bannerList = [];
  List<CommonModel> _localNavList = [];
  double _appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _onScroll(double scrollTop) {
    double alpha = scrollTop / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  _loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        _localNavList = model.localNavList!;
        _bannerList = model.bannerList!;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: [
          MediaQuery.removePadding(
              context: context,
              removeTop: true, // 移除上方安全區域
              child: NotificationListener(
                onNotification: (ScrollNotification ev) {
                  // 是 listview 滾動時才觸發, depth 是 child 第 ? 個可滾動元素
                  if (ev is ScrollUpdateNotification && ev.depth == 0) {
                    _onScroll(ev.metrics.pixels);
                  }
                  return false;
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 160,
                      child: Swiper(
                        itemCount: _bannerList.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int i) {
                          return Image.network(
                            _bannerList[i].icon!,
                            fit: BoxFit.cover,
                          );
                        },
                        pagination: const SwiperPagination(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: _localNavList),
                    ),
                    SizedBox(
                      height: 1000,
                      child: Text('123'),
                    )
                  ],
                ),
              )),
          Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首頁'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
