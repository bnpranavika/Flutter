import 'package:flutter/material.dart';

class AnimatedUITab extends StatefulWidget {
  const AnimatedUITab({super.key});

  @override
  State<AnimatedUITab> createState() => _AnimatedTypesTab();
}

class _AnimatedTypesTab extends State<AnimatedUITab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  double _opacity = 1.0;
  double _leftPosition = 50;

  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Rotation animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimations() {
    setState(() {
      _isExpanded = !_isExpanded;
      _opacity = _opacity == 1.0 ? 0.3 : 1.0;
      _leftPosition = _leftPosition == 50 ? 150 : 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated UI Elements")),
      body: Stack(
        children: [
          // AnimatedPositioned
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: _leftPosition,
            top: 50,
            child: Container(
              width: 80,
              height: 80,
              color: Colors.orange,
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AnimatedContainer
                AnimatedContainer(
                  width: _isExpanded ? 200 : 100,
                  height: _isExpanded ? 200 : 100,
                  color: _isExpanded ? Colors.blue : Colors.red,
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: const Text(
                    "Tap Button",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 30),

                // AnimatedOpacity
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 1),
                  child: const Icon(Icons.star, size: 50, color: Colors.purple),
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
        ],
      ),
    );
  }
}
