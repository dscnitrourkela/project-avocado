package in.ac.nitrkl.scp;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import in.ac.nitrkl.scp.adapter.FaqAdapter;
import in.ac.nitrkl.scp.model.FaqModel;
import in.ac.nitrkl.scp.scp.R;
import io.appbase.client.AppbaseClient;

public class FaqActivity extends AppCompatActivity {
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

        new SearchFetch("").execute();
    }
    String result="";
    private class SearchFetch extends AsyncTask{
        String searchText;
        SearchFetch(String searchText){
            this.searchText=searchText;
        }

        @Override
        protected String doInBackground(Object[] objects) {
            if (searchText.equalsIgnoreCase("")) {
                try {
                    result = client.prepareSearch(Constants.APP_NAME, Constants.QUERY)
                            .execute()
                            .body()
                            .string();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            else{
                searchText=Constants.QUERY_PREFIX+searchText+Constants.QUERY_SUFFIX;
                try {
                    result=client.prepareSearch(Constants.APP_NAME,searchText)
                            .execute()
                            .body()
                            .string();
                } catch (IOException e) {
                    e.printStackTrace();
                }
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        MenuInflater inflater=getMenuInflater();
        inflater.inflate(R.menu.menu_search,menu);
        MenuItem item=menu.findItem(R.id.button_search);
        SearchView searchView=(SearchView)item.getActionView();
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
             return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                return false;
            }
        });



        return super.onCreateOptionsMenu(menu);
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
