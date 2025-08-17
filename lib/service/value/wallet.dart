import 'package:decimal/decimal.dart';
import 'package:magicraft_wallet/controller/service/wallet.dart';
import 'package:magicraft_wallet/service/enum/wallet.dart';

String shortenAddress(
  String address, {
  int startChars = 4,
  int endChars = 4,
}) {
  try {
    if (address.length <= startChars + endChars) return address;
    return '${address.substring(0, startChars)}...${address.substring(address.length - endChars)}';
  } catch (e) {
    return address;
  }
}

String networkAddress(
  String chainId,
) {
  var result = '';

  if (chainId.split(":").first == 'bip122') {
    result = "BTC Address";
  }

  if (chainId.split(":").first == 'eip155') {
    result = "ETH Address";
  }

  if (chainId.split(":").first == 'solana') {
    result = "SOL Address";
  }

  return result;
}

String titleRequestType(
  WalletRequestType type,
) {
  if (type == WalletRequestType.SIGNATURE) {
    return "Confirm Signature";
  }

  if (type == WalletRequestType.WALLET_CONNECT) {
    return "Connect Wallet";
  }

  if (type == WalletRequestType.CONFIRMATION) {
    return "Confirm Transaction";
  }

  if (type == WalletRequestType.SEND_TRANSACTION) {
    return "Send Transaction";
  }

  return "";
}

String actionRequestType(
  WalletRequestType type,
) {
  if (type == WalletRequestType.SIGNATURE) {
    return "Sign";
  }

  if (type == WalletRequestType.WALLET_CONNECT) {
    return "Connect";
  }

  if (type == WalletRequestType.CONFIRMATION) {
    return "Confirm";
  }

  if (type == WalletRequestType.SEND_TRANSACTION) {
    return "Send";
  }

  return "";
}

double formatTokenAmount(
  BigInt amount,
  int decimals,
) {
  final amountDecimal = Decimal.fromBigInt(amount);
  final divisor = Decimal.parse('1${'0' * decimals}');
  final result = amountDecimal / divisor;
  return result.toDouble();
}

BigInt parseTokenAmount(
  String input,
  int decimals,
) {
  final decimalValue = Decimal.parse(input);
  final multiplier = Decimal.parse('1${'0' * decimals}'); // 10^decimals
  return (decimalValue * multiplier).toBigInt();
}

var listEvent = [
  'accountsChanged',
  'chainChanged',
  'message',
  'disconnect',
  'onSessionProposal',
  'onSessionRequest',
  'onSessionDelete',
  'onSessionExpire',
  'onSessionUpdate',
  'onSessionEvent',
  'onSessionPing',
];

final listSupportedMethods = {
  'eip155': {
    "eth_accounts": WalletAppController.ethAccounts,
    "eth_requestAccounts": WalletAppController.ethAccounts,
    "eth_sign": WalletAppController.ethSign,
    "personal_sign": WalletAppController.personalSign,
    "eth_signTransaction": WalletAppController.ethSignTransaction,
    "eth_signTypedData_v4": null,
    "eth_sendTransaction": WalletAppController.ethSendTransaction,
    "eth_sendRawTransaction": null,
    "wallet_switchEthereumChain": WalletAppController.walletSwitchEthereumChain,
    "wallet_addEthereumChain": null,
    "wallet_watchAsset": null,
  },
};
