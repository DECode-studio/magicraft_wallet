import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String BASE_URL = dotenv.env['API_APP_URL'] ?? '';

  // Auth URL
  static const VERIVY_AUTH_URL = '/api/v1/auth/verify';

  // Mint URL
  static const MINT_HISTORY_GET_URL = '/api/v1/token/detail';
  static const MINT_ERC721_REQUEST_URL = '/api/v1/erc-721/mint';

  // Data URL
  static const ASSET_DETAIL_GET_URL = '/api/v1/asset/get-asset-detail';
  static const ASSETS_GET_URL = '/api/v1/asset/get-assets';
  static const HISTORY_GET_URL = '/api/v1/asset/get-history';

  // Network URL
  static const NETWORK_PROVIDER_GET_URL =
      '/api/v1/network/get-network-providers';
  static const NETWORKS_GET_URL = '/api/v1/network/get-networks-by-address';
  static const NETWORK_ADD_URL = '/api/v1/network/add-network';

  // Bookmark URL
  static const BOOKMARK_ADDRESS_GET_URL = "/api/v1/bookmark/get-adress";
  static const BOOKMARK_ADDRESS_ADD_URL = "/api/v1/bookmark/add-address";
  static const BOOKMARK_ADDRESS_DELETE_URL = "/api/v1/bookmark/delete-address";

  static const BOOKMARK_GET_URL = "/api/v1/bookmark/get-url";
  static const BOOKMARK_ADD_URL = "/api/v1/bookmark/add-url";
  static const BOOKMARK_DELETE_URL = "/api/v1/bookmark/delete-url";
}
