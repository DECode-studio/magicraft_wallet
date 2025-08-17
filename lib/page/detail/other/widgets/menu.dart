import 'package:magicraft_wallet/model/local/menu.dart';
import 'package:hugeicons/hugeicons.dart';

List<GridMenuItemModel> listMenu() => [
      GridMenuItemModel(
        iconMenu: HugeIcons.strokeRoundedBookmark03,
        textMenu: 'Bookmark',
        actionMethod: 'address-bookmark',
      ),
      GridMenuItemModel(
        iconMenu: HugeIcons.strokeRoundedShieldBlockchain,
        textMenu: 'Mint NFT',
        actionMethod: 'mint-nft',
      ),
      GridMenuItemModel(
        iconMenu: HugeIcons.strokeRoundedBlockchain03,
        textMenu: 'Mint ERC20',
        actionMethod: 'mint-token',
      ),
      GridMenuItemModel(
        iconMenu: HugeIcons.strokeRoundedCoinsSwap,
        textMenu: 'Swap',
        actionMethod: 'swap-token',
      ),
      GridMenuItemModel(
        iconMenu: HugeIcons.strokeRoundedPieChart02,
        textMenu: 'Recomend',
        actionMethod: 'recomendation',
      ),
    ];
