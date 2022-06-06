import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
