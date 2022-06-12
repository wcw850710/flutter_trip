import 'package:flutter/material.dart';
import 'package:flutter_trip/lib/parse_color.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widgets/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;

  const GridNav({Key? key, required this.gridNavModel}) : super(key: key);

  List<Widget> _items(BuildContext context) {
    List<Widget> items = [];

    if (gridNavModel == null) return items;

    if (gridNavModel!.hotel != null) {
      items.add(_item(
        context,
        gridNavModel!.hotel!,
        first: true,
      ));
    }

    if (gridNavModel!.flight != null) {
      items.add(_item(
        context,
        gridNavModel!.flight!,
      ));
    }

    if (gridNavModel!.travel != null) {
      items.add(_item(
        context,
        gridNavModel!.travel!,
      ));
    }

    return items;
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
              hideAppBar: e.hideAppBar ?? false,
            ),
          ),
        );
      },
      child: widget,
    );
  }

  Widget _mainItem(BuildContext context, CommonModel e) {
    return _wrapGesture(
      context,
      e,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.network(
            e.icon!,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11),
            child: Text(
              e.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel e, {first = false}) {
    const BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);

    return _wrapGesture(
      context,
      e,
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            top: first ? BorderSide.none : borderSide,
          ),
        ),
        child: Center(
          child: Text(
            e.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _doubleItems(BuildContext context, CommonModel e1, CommonModel e2) {
    return Column(
      children: [
        Expanded(child: _doubleItem(context, e1, first: true)),
        Expanded(child: _doubleItem(context, e2)),
      ],
    );
  }

  Widget _item(BuildContext context, GridNavItem e, {bool first = false}) {
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          parseColor(e.startColor!),
          parseColor(e.endColor!),
        ]),
      ),
      child: Row(
        children: [
          Expanded(
            child: _mainItem(context, e.mainItem!),
            flex: 1,
          ),
          Expanded(
            child: _doubleItems(context, e.item1!, e.item2!),
            flex: 1,
          ),
          Expanded(
            child: _doubleItems(context, e.item3!, e.item4!),
            flex: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      // 類似遮罩
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _items(context),
      ),
    );
  }
}
