import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../supabase_config.dart';
import 'session_screen.dart';

class MatchingScreen extends StatefulWidget {
  final int duration;
  final String goal;
  const MatchingScreen({super.key, required this.duration, required this.goal});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  String? _sessionId;

  @override
  void initState() {
    super.initState();
    _startMatching();
  }

  Future<void> _startMatching() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    final waiting = await supabase
        .from('sessions')
        .select()
        .eq('status', 'waiting')
        .eq('language', 'es')
        .neq('user_id', userId)
        .limit(1)
        .maybeSingle();

    if (waiting != null) {
      await supabase
          .from('sessions')
          .update({'status': 'matched', 'partner_id': userId})
          .eq('id', waiting['id']);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SessionScreen(
              duration: widget.duration,
              goal: widget.goal,
              sessionId: waiting['id'].toString(),
            ),
          ),
        );
      }
    } else {
      final result = await supabase
          .from('sessions')
          .insert({
            'user_id': userId,
            'goal': widget.goal,
            'duration': widget.duration,
            'language': 'es',
            'status': 'waiting',
          })
          .select()
          .single();

      _sessionId = result['id'].toString();

      supabase
          .from('sessions')
          .stream(primaryKey: ['id'])
          .eq('id', _sessionId!)
          .listen((data) {
            if (data.isNotEmpty && data[0]['status'] == 'matched') {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SessionScreen(
                      duration: widget.duration,
                      goal: widget.goal,
                      sessionId: _sessionId!,
                    ),
                  ),
                );
              }
            }
          });
    }
  }

  Future<void> _cancelMatching() async {
    if (_sessionId != null) {
      await supabase.from('sessions').delete().eq('id', _sessionId!);
    }
    if (mounted) Navigator.pop(context);
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
              const SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: Color(0xFF4AA064),
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
                onPressed: _cancelMatching,
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
