import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationPosition;
  late Animation<double> _animationRotation;
  late Animation<double> _animationScale;
  late Animation<double> _animationOpacity;

  int _selectedAnimation = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationPosition = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _animationRotation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _animationScale = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _animationOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void startAnimation(int animationType) {
    setState(() {
      _selectedAnimation = animationType;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => startAnimation(0),
                child: const Text('Slide'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => startAnimation(1),
                child: const Text('Rotate'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => startAnimation(2),
                child: const Text('Scale'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => startAnimation(3),
                child: const Text('Fade'),
              ),
            ],
          ),
          const SizedBox(height: 150),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              switch (_selectedAnimation) {
                case 0:
                  return Transform.translate(
                    offset: Offset(_animationPosition.value, 0),
                    child: _buildBox(),
                  );
                case 1:
                  return Transform.rotate(
                    angle: _animationRotation.value,
                    child: _buildBox(),
                  );
                case 2:
                  return Transform.scale(
                    scale: _animationScale.value,
                    child: _buildBox(),
                  );
                case 3:
                  return Opacity(
                    opacity: _animationOpacity.value,
                    child: _buildBox(),
                  );
                default:
                  return _buildBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBox() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
    );
  }
}
