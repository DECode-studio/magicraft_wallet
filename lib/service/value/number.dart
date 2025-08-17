import 'dart:math';

List<int> generateRandomIntList({
  required int min,
  required int max,
  required int count,
  List<int> exclude = const [],
  List<int> include = const [],
}) {
  final rand = Random();
  final Set<int> result = {};

  final validInclude = include
      .where((val) => val >= min && val <= max && !exclude.contains(val))
      .toSet();

  if (validInclude.length > count) {
    throw Exception(
      'The number of included values (${validInclude.length}) exceeds the requested count ($count).',
    );
  }

  result.addAll(validInclude);

  final possibleValues = List.generate(max - min + 1, (i) => i + min)
      .where((val) => !exclude.contains(val) && !result.contains(val))
      .toList();

  if (result.length + possibleValues.length < count) {
    throw Exception(
      'Count ($count) exceeds the number of available values (${possibleValues.length + result.length}) after applying exclusions and includes.',
    );
  }

  while (result.length < count) {
    final randomValue = possibleValues[rand.nextInt(possibleValues.length)];
    result.add(randomValue);
  }

  return result.toList()..shuffle();
}
