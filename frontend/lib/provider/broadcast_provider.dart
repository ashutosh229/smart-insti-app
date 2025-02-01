import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_insti_app/models/broadcast_schema.dart';

final broadcastProvider = FutureProvider<List<Broadcast>>((ref) async {
  await Future.delayed(const Duration(seconds: 2)); // Simulating delay
  return List.generate(
    10,
    (index) => Broadcast(
      title: 'Broadcast $index',
      body: 'This is the body of broadcast $index.',
      date: DateTime.now().subtract(Duration(days: index)),
    ),
  );
});
