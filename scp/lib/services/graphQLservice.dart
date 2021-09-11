import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink("https://ics.dscnitrourkela.org/graphql");

class GraphQLService {
  ValueNotifier<GraphQLClient> valueclient = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache()));
}
