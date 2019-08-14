import 'dart:async';
import 'dart:convert';
import 'package:scp/mentor_search/mentor_model.dart';

import 'appbase_search_quries.dart';

import 'package:http/http.dart' as http;

class AppBaseSearchHandler {
  static Future<Response> searchRollNo(String rollNo) async {
    //var httpClient = http.Client();
    final response = await http.post(AppBaseQueries.baseUrl, body: {
      "query": {
        "match": {
          "rollNo": "$rollNo"
          }
      }
    });

    if(response.statusCode==200){
      return Response.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load post');
    }
  }
}
