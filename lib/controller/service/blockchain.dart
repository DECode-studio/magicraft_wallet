import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:magicraft_wallet/service/function/log.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'dart:typed_data';

class BlockchainUtils {
  // Generate Seed Phrase

  static String createNewSeedPhrase() {
    return bip39.generateMnemonic(strength: 128);
  }

  // Generate Private Key

  static EthPrivateKey? generateEthPrivateKeyFromSeedPhrase(
    String seedPhrase, {
    String derivationPath = "m/44'/60'/0'/0/0",
  }) {
    if (!bip39.validateMnemonic(seedPhrase)) {
      printLog('Invalid seed phrase.');
      return null;
    }

    try {
      final seed = bip39.mnemonicToSeed(seedPhrase);
      final hdNode = bip32.BIP32.fromSeed(seed);
      final child = hdNode.derivePath(derivationPath);

      if (child.privateKey == null) {
        printLog('Failed to get private key from derivation path.');
        return null;
      }

      final privateKeyHex = HEX.encode(child.privateKey!);
      return EthPrivateKey.fromHex(privateKeyHex);
    } catch (e) {
      printLog('Error generating private key from seed phrase: $e');
      return null;
    }
  }

  // Generate Public Key

  static Uint8List? generateEthPublicKeyFromPrivateKey(
    EthPrivateKey privateKey,
  ) {
    try {
      return privateKeyToPublic(privateKey.privateKeyInt);
    } catch (e) {
      printLog('Error generating Ethereum public key from private key: $e');
      return null;
    }
  }

  // Generate Wallet Address

  static EthereumAddress? generateEthAddressFromPublicKey(
    Uint8List publicKey,
  ) {
    try {
      return EthereumAddress.fromPublicKey(publicKey);
    } catch (e) {
      printLog('Error generating Ethereum address from public key: $e');
      return null;
    }
  }
}
