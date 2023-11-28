String? requreField(value) {
  if (value == null || value.isEmpty) {
    return 'Field is require';
  } else {
    return null;
  }
}
