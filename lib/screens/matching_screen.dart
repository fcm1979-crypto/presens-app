import 'package:flutter/material.dart';
import 'session_screen.dart';

class MatchingScreen extends StatefulWidget {
  final int duration;
  final String goal;
  const MatchingScreen({super.key, required this.duration, required this.goal});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                SessionScreen(duration: widget.duration, goal: widget.goal),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1810),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: const Color(0xFF4AA064),
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Buscando compañero…',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFE8F5ED),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Español · ${widget.duration} min · Silencio',
                style: const TextStyle(fontSize: 13, color: Color(0xFF4D7A5E)),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFF3D6050), fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
