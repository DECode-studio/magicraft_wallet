String formatBalance({
  required String symbol,
  required double amount,
}) {
  if (amount == 0) return '0 $symbol';
  if (amount < 0.00001) return '< 0.00001 $symbol';
  return '${amount.toStringAsFixed(5)} $symbol';
}
