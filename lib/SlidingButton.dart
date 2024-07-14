import 'package:flutter/material.dart';


class SlidingButtonExample extends StatefulWidget {
  @override
  _SlidingButtonExampleState createState() => _SlidingButtonExampleState();
}

class _SlidingButtonExampleState extends State<SlidingButtonExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta! / 200;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.value >= 0.5) {
      _controller.forward(from: _controller.value);
      setState(() {
        _isCompleted = true;
      });
      // You can perform any action here when the button is fully slid.
    } else {
      _controller.reverse(from: _controller.value);
      setState(() {
        _isCompleted = false;
      });
      // Handle when the button is not fully slid.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Button Example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return GestureDetector(
              onHorizontalDragUpdate: _handleDragUpdate,
              onHorizontalDragEnd: _handleDragEnd,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: _isCompleted?Colors.green:Colors.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: _controller.value * 150,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _isCompleted ? 'Slide Completed!' : 'Slide to Proceed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}