import 'package:flutter/material.dart';

class AnimatedTypesTab extends StatefulWidget {
  const AnimatedTypesTab({super.key});

  @override
  State<AnimatedTypesTab> createState() => _AnimatedTypesTabState();
}

class _AnimatedTypesTabState extends State<AnimatedTypesTab>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  bool _slideRight = true;
  double _scale = 1.0;

  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Rotation Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
            begin: const Offset(-1, 0), end: const Offset(1, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimations() {
    setState(() {
      _visible = !_visible;
      _slideRight = !_slideRight;
      _scale = _scale == 1.0 ? 1.5 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Different Animations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade Animation
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.2,
              duration: const Duration(seconds: 1),
              child: const Icon(Icons.favorite, size: 50, color: Colors.red),
            ),
            const SizedBox(height: 30),

            // Slide Animation
            AnimatedSlide(
              offset: _slideRight ? const Offset(1, 0) : const Offset(-1, 0),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child:
                  const Icon(Icons.arrow_forward, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 30),

            // Scale Animation
            AnimatedScale(
              scale: _scale,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: const Icon(Icons.star, size: 50, color: Colors.orange),
            ),
            const SizedBox(height: 30),

            // Rotation Animation using AnimatedBuilder
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: 60,
                height: 60,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: _toggleAnimations,
              child: const Text("Toggle Animations"),
            ),
          ],
        ),
      ),
    );
  }
}
