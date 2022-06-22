part of validator;

// Helper functions for validator and sanitizer.

_shift(List l) {
  if (l.isNotEmpty) {
    var first = l.first;
    l.removeAt(0);
    return first;
  }
  return null;
}

Map _merge(Map obj, defaults) {
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}