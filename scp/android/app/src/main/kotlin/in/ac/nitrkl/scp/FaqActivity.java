package in.ac.nitrkl.scp;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import in.ac.nitrkl.scp.adapter.FaqAdapter;
import in.ac.nitrkl.scp.model.FaqModel;
import in.ac.nitrkl.scp.scp.R;
import io.appbase.client.AppbaseClient;

public class FaqActivity extends Activity {
    AppbaseClient client=new AppbaseClient(Constants.BASE_URL,
            Constants.APP_NAME,Constants.USERNAME,Constants.PASSWORD);

    String query = Constants.QUERY;

    private RecyclerView recyclerView;
    private RecyclerView.Adapter adapter;

    private List<FaqModel> faqModels=new ArrayList<>();;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_faq);
        setTitle("FAQ");

        //Setting up RecyclerView
        recyclerView=(RecyclerView)findViewById(R.id.faq_rv);
        recyclerView.setHasFixedSize(true);
        LinearLayoutManager llm=new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(llm);
        adapter=new FaqAdapter(faqModels,getApplicationContext());
        recyclerView.setAdapter(adapter);

        new SearchFetch().execute();
    }
    String result="";
    private class SearchFetch extends AsyncTask{

        @Override
        protected String doInBackground(Object[] objects) {
            try {
                result =client.prepareSearch(Constants.APP_NAME, Constants.QUERY)
                        .execute()
                        .body()
                        .string();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return result;
        }

        @Override
        protected void onPostExecute(Object o) {
            super.onPostExecute(o);
            try {

                loadUrlData(result);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

    private void loadUrlData(String result) throws JSONException {
        JSONObject jsonObject=new JSONObject(result).getJSONObject("hits");
        JSONArray array=jsonObject.getJSONArray("hits");
        for(int i=0;i<array.length();i++){
            JSONObject jo=array.getJSONObject(i).getJSONObject("_source");
            Toast.makeText(getApplicationContext(),jo.getString("Question"),Toast.LENGTH_SHORT).show();
            faqModels.add(new FaqModel(jo.getString("Question"), jo.getString("Answer")));
            Toast.makeText(getApplicationContext(),"Called",Toast.LENGTH_SHORT).show();
        }
        adapter.notifyDataSetChanged();



    }
}
