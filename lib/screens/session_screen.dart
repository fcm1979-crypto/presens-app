import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'finish_screen.dart';

class SessionScreen extends StatefulWidget {
  final int duration;
  final String goal;
  final String sessionId;
  const SessionScreen({
    super.key,
    required this.duration,
    required this.goal,
    required this.sessionId,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  late int _secondsLeft;
  Timer? _timer;
  final _jitsi = JitsiMeet();

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.duration * 60;
    _startTimer();
    _startJitsi();
  }

  Future<void> _startJitsi() async {
    final options = JitsiMeetConferenceOptions(
      room: 'presens-${widget.sessionId}',
      configOverrides: {
        'startWithAudioMuted': true,
        'startWithVideoMuted': false,
        'disableDeepLinking': true,
      },
      featureFlags: {
        'chat.enabled': false,
        'invite.enabled': false,
        'recording.enabled': false,
        'live-streaming.enabled': false,
        'meeting-name.enabled': false,
        'meeting-password.enabled': false,
        'tile-view.enabled': false,
        'toolbox.enabled': false,
      },
    );
    await _jitsi.join(options);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _endSession();
      }
    });
  }

  void _endSession() {
    _timer?.cancel();
    _jitsi.hangUp();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FinishScreen(duration: widget.duration),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeDisplay {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _progress => 1 - (_secondsLeft / (widget.duration * 60));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1D3D2B),
                          border: Border.all(color: const Color(0xFF2A5A3E)),
                        ),
                        child: const Center(
                          child: Text(
                            'MG',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6DBF85),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compañero',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFB0CDB8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'en vivo',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF4D7A5E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF162A1E),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: const Color(0xFF1E3528)),
                    ),
                    child: const Text(
                      '🔇 Silencio',
                      style: TextStyle(fontSize: 11, color: Color(0xFF4D7A5E)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 6,
                      backgroundColor: const Color(0xFF1E2E24),
                      color: const Color(0xFF4AA064),
                      strokeCap: StrokeCap.round,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _timeDisplay,
                          style: const TextStyle(
                            fontSize: 36,
                            color: Color(0xFFE8F5ED),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Text(
                          'restante',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4D7A5E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF162A1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E3528)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TU OBJETIVO',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.8,
                        color: Color(0xFF4D7A5E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.goal.isEmpty
                          ? 'Sin objetivo definido'
                          : '"${widget.goal}"',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFB0CDB8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _endSession,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4D7A5E),
                    side: const BorderSide(color: Color(0xFF1E3528)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Terminar sesión'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
