class AppBaseQueries{
  static String searchRollNo = "719MN1044";
  static String baseUrl = "https://21rPMKNpj:fb4bde99-ad06-4830-bc01-39c345d71463@scalr.api.appbase.io/project-avocado-scs/doc/_search";
  static String contactSearchQuery = "{\"query\": "+"{\"match\": "+"{\"rollNo\": \"$searchRollNo\""+"}}}";
  static String mentorContactSearchQueryUrl = baseUrl + contactSearchQuery;
}