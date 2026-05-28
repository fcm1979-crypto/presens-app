import 'package:flutter/material.dart';
import 'new_session_screen.dart';

class FinishScreen extends StatelessWidget {
  final int duration;
  const FinishScreen({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D3D2B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2A5A3E)),
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF6DBF85),
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Sesión completada!',
                style: TextStyle(
                  fontSize: 26,
                  color: Color(0xFFE8F5ED),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$duration minutos de foco. Bien hecho.',
                style: const TextStyle(fontSize: 14, color: Color(0xFF4D7A5E)),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  _statCard('$duration', 'min hoy'),
                  const SizedBox(width: 10),
                  _statCard('9', 'días racha'),
                  const SizedBox(width: 10),
                  _statCard('24', 'sesiones'),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_outlined, size: 18),
                      label: const Text('Buena'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4D7A5E),
                        side: const BorderSide(color: Color(0xFF1E3528)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_down_outlined, size: 18),
                      label: const Text('Mejorable'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4D7A5E),
                        side: const BorderSide(color: Color(0xFF1E3528)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NewSessionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4AA064),
                    foregroundColor: const Color(0xFF0C1810),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Nueva sesión',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF162A1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1E3528)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6DBF85),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF4D7A5E)),
            ),
          ],
        ),
      ),
    );
  }
}
