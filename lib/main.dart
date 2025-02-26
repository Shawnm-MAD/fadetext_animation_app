import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(
        toggleTheme: toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  FadingTextAnimation({required this.toggleTheme, required this.isDarkMode});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;
  bool _showFrame = false;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void changeTextColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  void showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a text color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: changeTextColor,
              showLabel: false,
              enableAlpha: false,
            ),
          ),
          actions: [
            TextButton(
              child: Text("Select"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// Build image with rounded corners and optional frame
  Widget _buildImage() {
  return GestureDetector(
    onTap: toggleVisibility,
    child: AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: _showFrame ? Border.all(color: Colors.blue, width: 5) : null,
        ),
        child: Image.asset('assets/images/436-4361094_imagenes-random-png.png'),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: showColorPickerDialog,
          ),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut, // Adding a curve for smoother animation
          child: Text(
            'Flutter is Awesome!',
            style: TextStyle(fontSize: 24, color: _textColor),
          ),
        ),
        SwitchListTile(
              title: Text('Show Frame'),
              value: _showFrame,
              onChanged: (bool value) {
                setState(() {
                  _showFrame = value;
                });
              },
            ),
            // Image with optional frame
            _buildImage(),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}