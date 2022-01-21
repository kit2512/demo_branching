class SimpleCache {
  final Map<String, Object?> cache;

  SimpleCache() : cache = <String, Object?>{};

  void write(String key, Object value) {
    cache[key] = value;
  }

  T? read<T extends Object>(String key) {
    final value = cache[key];
    if (value is T) {
      return value;
    }
    return null;
  }
}
