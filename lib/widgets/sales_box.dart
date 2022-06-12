import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widgets/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel? salesBoxModel;

  const SalesBox({Key? key, required this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (salesBoxModel == null) return Container();

    return Column(
      children: [
        _title(context),
        _items(context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(salesBoxModel!.icon!, height: 15, fit: BoxFit.fill),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView(
                        url: salesBoxModel!.moreUrl!,
                        title: '更多活動',
                      ),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Text(
                  '獲取更多福利 >',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, CommonModel e,
      {bool left = false, bool last = false, bool big = false}) {
    BorderSide borderSide =
        const BorderSide(width: 0.8, color: Color(0xfff2f2f2));

    return _wrapGesture(
        context,
        e,
        Container(
          decoration: BoxDecoration(
            border: Border(
                right: left ? borderSide : BorderSide.none,
                bottom: last ? BorderSide.none : borderSide),
          ),
          child: Image.network(
            e.icon!,
            fit: BoxFit.fill,
            // MediaQuery.of(context).size.width 屏幕寬度
            width: MediaQuery.of(context).size.width / 2 - (left ? 1 : 0),
            height: big ? 129 : 80,
          ),
        ));
  }

  Widget _items(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _item(context, salesBoxModel!.bigCard1!, big: true, left: true),
            _item(context, salesBoxModel!.bigCard1!, big: true)
          ],
        ),
        Row(
          children: [
            _item(context, salesBoxModel!.smallCard1!, left: true),
            _item(context, salesBoxModel!.smallCard2!)
          ],
        ),
        Row(
          children: [
            _item(context, salesBoxModel!.smallCard3!, left: true, last: true),
            _item(context, salesBoxModel!.smallCard4!, last: true)
          ],
        ),
      ],
    );
  }

  Widget _wrapGesture(BuildContext context, CommonModel e, Widget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                url: e.url!,
                statusBarColor: e.statusBarColor,
                hideAppBar: e.hideAppBar,
              ),
            ));
      },
      child: widget,
    );
  }
}
