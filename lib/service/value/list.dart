List<dynamic> mapToList(Map map, List<String> keys) {
  return keys.map((key) => map[key]).toList();
}
