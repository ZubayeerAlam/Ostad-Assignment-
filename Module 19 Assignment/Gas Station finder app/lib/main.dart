import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/locationProvider.dart';
import 'my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: const MyApp(),
    ),
  );
}
