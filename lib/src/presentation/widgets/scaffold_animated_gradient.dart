import 'package:flutter/material.dart';
import 'package:tictactoebetclic/src/presentation/widgets/animated_gradient_background_widget.dart';

class ScaffoldAnimatedGradient extends StatelessWidget {
  const ScaffoldAnimatedGradient({this.appBar, required this.body, super.key});

  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: appBar != null,
        appBar: appBar,
        body: Stack(
          children: [
            const AnimatedGradientBackground(),
            Padding(
              padding: appBar != null
                  ? const EdgeInsets.only(top: kToolbarHeight)
                  : const EdgeInsets.only(top: 0),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}