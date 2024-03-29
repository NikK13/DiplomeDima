import 'dart:async';
import 'package:flutter/material.dart';

class ShowUpAnimated extends StatefulWidget {
  final Widget? child;
  final int? delay;

  const ShowUpAnimated({Key? key, @required this.child, this.delay}) : super(key: key);

  @override
  State<ShowUpAnimated> createState() => _ShowUpAnimatedState();
}

class _ShowUpAnimatedState extends State<ShowUpAnimated> with TickerProviderStateMixin {
  AnimationController? _animController;
  Animation<Offset>? _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _animController!);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _animController!.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        _animController!.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController!,
      child: SlideTransition(
        position: _animOffset!,
        child: widget.child,
      ),
    );
  }
}