import 'dart:async';
import 'dart:convert';
import 'package:scp/mentor_search/mentor_model.dart';
import 'appbase_search_quries.dart';
import 'package:http/http.dart' as http;

class AppBaseSearchHandler {
  static Future<Response> searchRollNo(String rollNo) async {
    Map<String, dynamic> rollQuery = {
    'query': {
      'match': {
        "rollNo": "$rollNo"
      }
    }
  };
    //var httpClient = http.Client();
    final response = await http.post(AppBaseQueries.baseUrl, body: json.encode(rollQuery));

    if(response.statusCode==200){
      print(response.body);
      return Response.fromJson(json.decode(response.body));
    }
    else{
      print('Failed to load post');

      throw Exception('Failed to load post');
    }
  }
}
//I/flutter (24494): {"_shards":{"failed":0,"skipped":0,"successful":3,"total":3},"hits":{"hits":[],"max_score":null,"total":0},"timed_out":false,"took":1}

