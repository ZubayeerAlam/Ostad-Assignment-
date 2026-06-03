import 'package:flutter/material.dart';

class BloodRequestCard extends StatelessWidget {
  final String bloodType;
  final int units;
  final String hospital;

  const BloodRequestCard({
    super.key,
    required this.bloodType,
    required this.units,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // ── Red left border ──
            Container(
              width: 6,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // ── Card content ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // URGENT badge + Units
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // URGENT badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE5E5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'URGENT',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        // Units
                        Row(
                          children: [
                            const Icon(
                              Icons.water_drop,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$units Units',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Blood type title
                    Text(
                      '$bloodType Blood Needed',
                      style: const TextStyle(
                        color: Color(0xFF1A2B5F),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Hospital location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hospital,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // View Details button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A2B5F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}