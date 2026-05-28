import 'package:flutter/material.dart';
import 'matching_screen.dart';

class NewSessionScreen extends StatefulWidget {
  const NewSessionScreen({super.key});

  @override
  State<NewSessionScreen> createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  int _selectedDuration = 50;
  final _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const Text(
                '¿Cuánto\ntiempo?',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFFE8F5ED),
                  fontStyle: FontStyle.italic,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Elige la duración de tu sesión.',
                style: TextStyle(fontSize: 14, color: Color(0xFF4D7A5E)),
              ),
              const SizedBox(height: 32),
              Row(
                children: [25, 50, 75].map((duration) {
                  final selected = _selectedDuration == duration;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedDuration = duration),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF1D3D2B)
                                : const Color(0xFF162A1E),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF4AA064)
                                  : const Color(0xFF1E3528),
                            ),
                          ),
                          child: Text(
                            '$duration min',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? const Color(0xFF6DBF85)
                                  : const Color(0xFF4D7A5E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'TU OBJETIVO',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: Color(0xFF4D7A5E),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                style: const TextStyle(
                  color: Color(0xFFE8F5ED),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                decoration: InputDecoration(
                  hintText: 'Ej: Terminar el informe...',
                  hintStyle: const TextStyle(color: Color(0xFF3D6050)),
                  filled: true,
                  fillColor: const Color(0xFF162A1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF1E3528)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF1E3528)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF2D6040)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _filterCard('Idioma', '🇪🇸 Español')),
                  const SizedBox(width: 10),
                  Expanded(child: _filterCard('Modo', '🔇 Silencio')),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MatchingScreen(
                          duration: _selectedDuration,
                          goal: _goalController.text,
                        ),
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
                    'Buscar compañero',
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

  Widget _filterCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF162A1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3528)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 0.8,
              color: Color(0xFF4D7A5E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFFB0CDB8),
            ),
          ),
        ],
      ),
    );
  }
}
