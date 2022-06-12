import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool cover;

  const LoadingContainer(
      {Key? key, required this.child, this.loading = false, this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !loading
            ? child
            : _loadingView
        : Stack(
            children: [
              child,
              loading ? _loadingView : Container(),
            ],
          );
  }

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
