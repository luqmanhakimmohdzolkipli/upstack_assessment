import 'package:upstack_assessment/constants/api_constant.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:http/http.dart' as http;

class ListRepository {
  final http.Client httpClient = http.Client();

  Future<List<ListModel>> fetchLists({required int page, required int limit}) async {
    final response = await httpClient.get(
      headers: {'Authorization': 'Bearer ${ApiConstant.AUTH_TOKEN}'},
      Uri.https(
        ApiConstant.BASE_URL,
        ApiConstant.REPO_LIST,
        {'page': '$page', 'per_page': '$limit'},
      ),
    );
    if (response.statusCode == 200) {
      List<ListModel> listModel = listModelFromJson(response.body);
      return listModel;
    }
    return throw Exception('error fetching lists');
  }

  Future<List<ListModel>> fetchAllLists() async {
    final response = await httpClient.get(
      headers: {'Authorization': 'Bearer ${ApiConstant.AUTH_TOKEN}'},
      Uri.https(
        ApiConstant.BASE_URL,
        ApiConstant.REPO_LIST,
      ),
    );
    if (response.statusCode == 200) {
      List<ListModel> listModel = listModelFromJson(response.body);
      return listModel;
    }
    return throw Exception('error fetching lists');
  }
}
