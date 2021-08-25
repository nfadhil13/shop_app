import 'package:flutter/material.dart';

class LoadingStack extends StatelessWidget {


  final Widget child;

  LoadingStack(this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,

    ]);
  }
}
