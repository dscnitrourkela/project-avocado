import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';

final String readMentees = """
query Mentees(\$roll : String){
  mentor(rollNumber : \$roll){
    name
    rollNumber
    mentees{
      name
      rollNumber
      
    }
  }
}
""";

class MenteePageViewModel extends BaseViewModel {
  MenteePageViewModel(this.rollNo);

  String rollNo;

  QueryOptions query_options;
  void init() {
    query_options=QueryOptions(
      documentNode: gql(readMentees),
      variables: <String, dynamic>{"roll": rollNo});
  }
}
