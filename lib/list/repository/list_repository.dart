import 'dart:convert';
import 'dart:developer';
import 'package:github/github.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upstack_assessment/constants/api_constant.dart';
import 'package:upstack_assessment/list/model/list_model.dart';
import 'package:http/http.dart' as http;

class ListRepository {
  final http.Client httpClient = http.Client();

  Future<List<ListModel>> fetchLists({required int page}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await GitHub(
        auth: Authentication.withToken(
          '${token}',
        ),
      ).getJSON(
        ApiConstant.REPO_LIST,
        params: {
          'per_page': '10',
          'page': '$page',
        },
      );
      return listModelFromJson(jsonEncode(response));
    } catch (e) {
      return throw Exception('error fetching lists: $e');
    }
  }

  Future<List<ListModel>> fetchListByName({
    required int page,
    required String name,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await GitHub(
        auth: Authentication.withToken(
          '${token}',
        ),
      ).getJSON(
        '${ApiConstant.SEARCH_REPO_LIST}?q=$name+in%3Aname+org%3Aflutter&per_page=10&page=$page',
      );
      log('search response >>> ${response['items']}');
      return listModelFromJson(jsonEncode(response['items']));
    } catch (e) {
      return throw Exception('error fetching lists: $e');
    }
  }
}
