import 'package:flutter/material.dart';

// Coloured scale bar with a marker showing where the BMI falls (range 10–40)
class BmiScale extends StatelessWidget {
  const BmiScale({super.key, required this.bmi});

  final double bmi;

  static const double _minBmi = 10;
  static const double _maxBmi = 40;

  @override
  Widget build(BuildContext context) {
    final double position =
        ((bmi - _minBmi) / (_maxBmi - _minBmi)).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        return SizedBox(
          height: 28,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    children: [
                      // Widths proportional to each range on the 10–40 scale
                      Expanded(flex: 85, child: Container(height: 12, color: Colors.blue)),
                      Expanded(flex: 65, child: Container(height: 12, color: Colors.green)),
                      Expanded(flex: 50, child: Container(height: 12, color: Colors.orange)),
                      Expanded(flex: 100, child: Container(height: 12, color: Colors.red)),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: (width * position) - 10,
                top: -4,
                child: const Icon(Icons.arrow_drop_down, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
