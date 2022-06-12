import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widgets/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key? key, required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _item(BuildContext ctx, CommonModel e) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (context) => WebView(
                  url: e.url!,
                  statusBarColor: e.statusBarColor,
                  hideAppBar: e.hideAppBar,
                ),
              ));
        },
        child: Column(
          children: [
            Image.network(
              e.icon!,
              width: 18,
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                e.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget? _items(BuildContext ctx) {
    if (subNavList.isEmpty) return null;

    List<Widget> items = [];
    int oneLineNum = 5;

    subNavList.forEach((e) {
      items.add(_item(ctx, e));
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, oneLineNum),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(oneLineNum, subNavList.length),
          ),
        ),
      ],
    );
  }
}
