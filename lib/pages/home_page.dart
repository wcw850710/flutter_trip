import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

const double appbarScrollOffset = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://s.newtalk.tw/album/album/1/5f292c6b25a74.jpg',
    'http://s.newtalk.tw/album/album/1/5f2ba1d3d0c83.jpg',
    'http://s.newtalk.tw/album/album/1/5f2bd3ae5e8ee.jpg'
  ];
  double _appBarAlpha = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int i) {
                          return Image.network(
                            _imageUrls[i],
                            fit: BoxFit.cover,
                          );
                        },
                        pagination: const SwiperPagination(),
                      ),
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
              ))
        ],
      ),
    );
  }
}
