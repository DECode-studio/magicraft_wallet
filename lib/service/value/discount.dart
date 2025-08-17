int discountCalculation(
  double numerator,
  double denominator,
) {
  if (denominator == 0) return 0;
  var result = ((denominator - numerator) / denominator) * 100;
  return result.round();
}
