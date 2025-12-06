import 'dart:async';

class Ticker {
  const Ticker();
  Stream<int> tick({
    required int limit,
    required int startAt,
  }) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => x + startAt + 1,
    ).take(limit);
  }
}