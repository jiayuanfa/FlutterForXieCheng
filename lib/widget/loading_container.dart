
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
        isLoading? _loadingView : Container()
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
