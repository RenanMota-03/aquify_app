double parseDouble(String? value) {
  if (value == null || value.isEmpty) return 0.0;
  return double.tryParse(value) ?? 0.0;
}
