import 'package:magicraft_wallet/model/api/main.dart';
import 'package:magicraft_wallet/model/api/request/bookmark.dart';
import 'package:magicraft_wallet/model/api/response/bookmark.dart';
import 'package:magicraft_wallet/service/config/api.dart';
import 'package:magicraft_wallet/service/function/http_request.dart';
import 'package:magicraft_wallet/service/function/log.dart';

class BookmarkDataController extends HttpRequest {
  Future<List<AddressBookmarkModel>> getAddressBookmark() async {
    var result = <AddressBookmarkModel>[];

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_ADDRESS_GET_URL}');
      final res = await GET(url: url.toString());

      final data = ApiResponse<List<AddressBookmarkModel>>.fromJson(
        data: res.body,
        fromData: AddressBookmarkModel.fromListJson,
      );

      result = data.data ?? [];
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<ApiResponse> addAddressBookmark(
    AddressBookmarkRequest req,
  ) async {
    var result = ApiResponse();

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_ADDRESS_ADD_URL}');
      final res = await POST(
        url: url.toString(),
        req: req.toJson(),
        isJson: true,
      );

      final data = ApiResponse.fromJson(data: res.body);
      result = data;
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<ApiResponse> deleteAddressBookmark(
    String id,
  ) async {
    var result = ApiResponse();

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_ADDRESS_DELETE_URL}')
          .replace(
        queryParameters: {
          'id': id,
        },
      );

      final uri = url.toString();
      final res = await DELETE(url: uri);

      final data = ApiResponse.fromJson(data: res.body);
      result = data;

      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<List<UrlBookmarkModel>> getUrlBookmark() async {
    var result = <UrlBookmarkModel>[];

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_GET_URL}');
      final res = await GET(url: url.toString());

      final data = ApiResponse<List<UrlBookmarkModel>>.fromJson(
        data: res.body,
        fromData: UrlBookmarkModel.fromListJson,
      );

      result = data.data ?? [];
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<ApiResponse> addUrlBookmark(
    UrlBookmarkRequest req,
  ) async {
    var result = ApiResponse();

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_ADD_URL}');
      final res = await POST(
        url: url.toString(),
        req: req.toJson(),
        isJson: true,
      );

      final data = ApiResponse.fromJson(data: res.body);
      result = data;
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<ApiResponse> deleteUrlBookmark(
    String id,
  ) async {
    var result = ApiResponse();

    try {
      final url =
          Uri.parse('${Api.BASE_URL}${Api.BOOKMARK_DELETE_URL}').replace(
        queryParameters: {
          'id': id,
        },
      );

      final res = await DELETE(
        url: url.toString(),
      );

      final data = ApiResponse.fromJson(data: res.body);
      result = data;

      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }
}
