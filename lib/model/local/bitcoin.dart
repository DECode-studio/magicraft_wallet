class Utxo {
  final String txId;
  final int vout;
  final BigInt amount; // dalam satoshis

  Utxo({
    required this.txId,
    required this.vout,
    required this.amount,
  });
}
