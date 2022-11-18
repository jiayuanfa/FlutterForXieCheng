
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({
    Key? key,
    required this.child,
    required this.isLoading,
    this.cover = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return !cover ? !isLoading ? child : _loadingView :
    Stack(
      children: [
        child,
        isLoading? _loadingView : const Center(
          child: Text('暂无数据'),
        )
      ],
    );
  }

  /// Loading 提示
  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
