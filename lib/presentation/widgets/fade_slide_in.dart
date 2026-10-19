import 'package:banking_app/constants/animation_constant.dart';
import 'package:flutter/material.dart';

class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AnimationConstant.entrance,
    this.offsetY = AnimationConstant.entranceOffset,
    this.beginScale = 1,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;
  final double beginScale;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _fade = curve;
    _slide = Tween<double>(begin: widget.offsetY, end: 0).animate(curve);
    _scale = Tween<double>(begin: widget.beginScale, end: 1).animate(curve);
    _start();
  }

  Future<void> _start() async {
    if (widget.delay > Duration.zero) {
      await Future<void>.delayed(widget.delay);
    }
    if (mounted) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget content = child!;
        if (widget.beginScale != 1) {
          content = Transform.scale(scale: _scale.value, child: content);
        }
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: Offset(0, _slide.value),
            child: content,
          ),
        );
      },
      child: widget.child,
    );
  }
}
