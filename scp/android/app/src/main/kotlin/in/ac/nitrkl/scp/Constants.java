package in.ac.nitrkl.scp;

public class Constants {
    final static String BASE_URL="https://scalr.api.appbase.io";
    final static String APP_NAME="avocado_nit";
    final static String USERNAME="nxG0qRXse";
    final static String PASSWORD="e84e598a-6288-4cd0-bda4-b535898349f2";
    final static String QUERY="{\n" +
            " \"from\":0 , \n" +
            " \"size\":1000 , \n" +
            "   \"query\":{\n" +
            "      \"match_all\":{}\n" +
            "   }\n" +
            "}";
    final static String QUERY_PREFIX="{\n" +
            "   \"query\":{\n" +
            "      \"multi_match\" : {\n" +
            "         \"query\": ";
    final static String QUERY_SUFFIX=",\n" +
            "         \"fields\": [ \"Question\", \"Answer\" ]\n" +
            "      }\n" +
            "   }\n" +
            "}";
}
