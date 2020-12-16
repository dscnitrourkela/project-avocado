import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../utils/grapgQLconfig.dart';

final Color primaryColor = Color.fromARGB(255, 49, 68, 76);
final Color secondaryColor = Color.fromARGB(255, 158, 218, 224);
final Color lunchColor = Color.fromARGB(255, 238, 71, 89);

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

class ListDetails extends StatelessWidget {
  final String rollNo;
  ListDetails(this.rollNo);
  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            60.0,
          ),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                'Your Mentees',
                style: TextStyle(
                    fontSize: queryWidth * 0.065,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w500),
              ),
            ),
            backgroundColor: Color.fromRGBO(
              54,
              66,
              87,
              1.0,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            elevation: 0.0,
          ),
        ),
        body: GraphQLProvider(
          client: valueclient,
          child: MenteeDetails(rollNo),
        ));
  }
}

class MenteeDetails extends StatelessWidget {
  final String rollNo;
  MenteeDetails(this.rollNo);
  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
    return Query(
        options: QueryOptions(
            documentNode: gql(readMentees),
            variables: <String, dynamic>{"roll": rollNo}),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Center(
              child: Text("Please check your internet connection"),
            );
          }
          if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.data["mentor"] == null) {
            return Center(
              child: Text(
                "You are not a mentor",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result.data["mentor"]["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: queryWidth * 0.1,
                      fontWeight: FontWeight.bold),
                ),
                Text(result.data["mentor"]["rollNumber"],
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: queryWidth * 0.075,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: queryWidth * 0.07,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: queryWidth * 0.05),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      "MENTEE NAME",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: queryWidth * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "ROLL NO",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: queryWidth * 0.055,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: queryWidth * 0.05),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: result.data["mentor"]["mentees"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          result.data["mentor"]["mentees"][index]["name"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: queryWidth * 0.042,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          result.data["mentor"]["mentees"][index]["rollNumber"],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: queryWidth * 0.038,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
          //return Center(child: Text(result.data["mentor"]["name"].toString()));
        });
  }
}
