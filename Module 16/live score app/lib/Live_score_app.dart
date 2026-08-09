import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LiveScoreApp extends StatelessWidget {
  LiveScoreApp({super.key});

  final doc = FirebaseFirestore.instance
      .collection('Matches')
      .doc('live_match');

  void addRun(int run) {
    doc.update({
      "runs": FieldValue.increment(run),
    });
  }

  void addWicket() {
    doc.update({
      "wickets": FieldValue.increment(1),
    });
  }

  void nextBall() {
    doc.get().then((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;

      int balls = data['balls'] ?? 0;

      balls++;

      int over = balls ~/ 6;
      int ball = balls % 6;

      doc.update({
        "balls": balls,
        "overs": "$over.$ball",
      });
    });
  }

  void resetScore() {
    doc.update({
      "runs": 0,
      "wickets": 0,
      "balls": 0,
      "overs": "0.0",
      "status": "Live",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live score app'),
        backgroundColor: Colors.orange,
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: doc.snapshots(),
        builder: (context, asyncSnapshot) {
          final data =
          asyncSnapshot.data?.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(20.0),

            child: Column(
              children: [
                Text(
                  '${data['teamA']} vs ${data['teamB']}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 40),

                Text(
                  '${data['runs']} runs / ${data['wickets']}',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Over : ${data['overs']}',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),

                Text(
                  ' ${data['status']}',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                  ),
                ),

                SizedBox(height: 40),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,

                  children: [
                    ElevatedButton(
                      onPressed: () {
                        addRun(1);
                      },
                      child: Text('+1 run'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        addRun(4);
                      },
                      child: Text('Four'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        addRun(6);
                      },
                      child: Text('Six'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        addWicket();
                      },
                      child: Text('Wicket'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        nextBall();
                      },
                      child: Text('Next Ball'),
                    ),


                    ElevatedButton(
                      onPressed: () {
                        resetScore();
                      },
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}