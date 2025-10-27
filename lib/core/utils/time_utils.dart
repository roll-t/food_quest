class TimeUtils {
  static DateTime? _lastActionTime;

  static bool canPerformAction({int cooldownMs = 1000}) {
    final now = DateTime.now();

    if (_lastActionTime == null ||
        now.difference(_lastActionTime!).inMilliseconds >= cooldownMs) {
      _lastActionTime = now;
      return true;
    }
    return false;
  }
}
