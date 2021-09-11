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

  QueryOptions queryOptions;
  void init() {
    queryOptions = QueryOptions(
        document: gql(readMentees),
        variables: <String, dynamic>{"roll": rollNo});
  }
}
