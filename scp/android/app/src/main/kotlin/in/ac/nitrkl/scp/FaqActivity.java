package in.ac.nitrkl.scp;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.SearchView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.facebook.shimmer.ShimmerFrameLayout;
import in.ac.nitrkl.scp.adapter.FaqAdapter;
import in.ac.nitrkl.scp.model.FaqModel;
import in.ac.nitrkl.scp.scp.R;
import io.appbase.client.AppbaseClient;
import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.google.android.material.snackbar.Snackbar;

public class FaqActivity extends AppCompatActivity {
  AppbaseClient client = new AppbaseClient(Constants.BASE_URL,
      Constants.APP_NAME, Constants.USERNAME, Constants.PASSWORD);
  String result = "";
  boolean FAQquery = false;
  private RecyclerView recyclerView;
  private RecyclerView.Adapter adapter;
  private List<FaqModel> faqModels = new ArrayList<>();
  private ShimmerFrameLayout shimmerFrameLayout;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_faq);
    setTitle("FAQ");

    shimmerFrameLayout = findViewById(R.id.shimmer_view_container);
    shimmerFrameLayout.startShimmerAnimation();
    shimmerFrameLayout.setVisibility(View.VISIBLE);

    getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    getSupportActionBar().setBackgroundDrawable(getResources().getDrawable(R.color.faq_actionBar));
    //Setting up RecyclerView
    recyclerView = (RecyclerView) findViewById(R.id.faq_rv);
    recyclerView.setHasFixedSize(true);
    LinearLayoutManager llm = new LinearLayoutManager(this);
    llm.setOrientation(RecyclerView.VERTICAL);
    recyclerView.setLayoutManager(llm);
    adapter = new FaqAdapter(faqModels, getApplicationContext());
    recyclerView.setAdapter(adapter);

    new SearchFetch("").execute();// This is the initial list that is shown
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    MenuInflater inflater = getMenuInflater();
    inflater.inflate(R.menu.menu_search, menu);
    MenuItem item = menu.findItem(R.id.button_search);
    SearchView searchView = (SearchView) item.getActionView();
    searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
      @Override
      public boolean onQueryTextSubmit(String query) {
        faqModels.clear();
        setTitle(query);
        FAQquery = true;
        adapter.notifyDataSetChanged();
        shimmerFrameLayout.startShimmerAnimation();
        shimmerFrameLayout.setVisibility(View.VISIBLE);
        new SearchFetch(query).execute();
        //Toast.makeText(getApplicationContext(),query,Toast.LENGTH_LONG).show();
        searchView.setIconified(true);
        searchView.clearFocus();
        searchView.onActionViewCollapsed();
        menu.findItem(R.id.button_search).collapseActionView();
        return false;
      }

      @Override
      public boolean onQueryTextChange(String newText) {

        if (newText.equalsIgnoreCase("")) {
          return true;
        }
        setTitle("");
        faqModels.clear();
        FAQquery = true;
        adapter.notifyDataSetChanged();
        //Toast.makeText(getApplicationContext(),newText,Toast.LENGTH_LONG).show();
        shimmerFrameLayout.startShimmerAnimation();
        shimmerFrameLayout.setVisibility(View.VISIBLE);
        new SearchFetch(newText).execute();
        return true;
      }
    });

    return super.onCreateOptionsMenu(menu);
  }

  @Override
  public void onBackPressed() {
    if (FAQquery) {
      faqModels.clear();
      adapter.notifyDataSetChanged();
      shimmerFrameLayout.startShimmerAnimation();
      shimmerFrameLayout.setVisibility(View.VISIBLE);
      new SearchFetch("").execute();// This is the initial list that is shown
      FAQquery = false;
      setTitle("FAQ");
    } else {
      super.onBackPressed();
    }
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem menuItem) {
    switch (menuItem.getItemId()) {
      case android.R.id.home:
        if (FAQquery) {
          faqModels.clear();
          adapter.notifyDataSetChanged();
          shimmerFrameLayout.startShimmerAnimation();
          shimmerFrameLayout.setVisibility(View.VISIBLE);
          new SearchFetch("").execute();// This is the initial list that is shown
          FAQquery = false;
          setTitle("FAQ");
          menuItem.collapseActionView();
        } else {
          finish();
        }
        return false;
      default:
        return super.onOptionsItemSelected(menuItem);
    }
  }

  private void loadUrlData(String result) throws JSONException {
    JSONObject jsonObject = new JSONObject(result).getJSONObject("hits");
    JSONArray array = jsonObject.getJSONArray("hits");
    List<String> categories = new ArrayList<>();
    for (int i = 0; i < array.length(); i++) {
      JSONObject jo = array.getJSONObject(i).getJSONObject("_source");
      JSONArray cat = jo.getJSONArray("Category");
      for (int j = 0; j < cat.length(); j++) {
        categories.add(cat.getString(j));
      }
      faqModels.add(new FaqModel(jo.getString("Question"), jo.getString("Answer"), categories));
    }
    shimmerFrameLayout.stopShimmerAnimation();
    shimmerFrameLayout.setVisibility(View.GONE);
    adapter.notifyDataSetChanged();
  }

  private class SearchFetch extends AsyncTask {
    String searchText;

    SearchFetch(String searchText) {
      this.searchText = searchText;
    }

    @Override
    protected String doInBackground(Object[] objects) {
      if (!isInternetAvailable()) {
        Snackbar.make(findViewById(R.id.root), "There's no internet connection", Snackbar.LENGTH_LONG).show();
        return null;
      }

      if (searchText.equalsIgnoreCase("")) {
        try {
          result = client.prepareSearch(Constants.APP_NAME, Constants.QUERY)
              .execute()
              .body()
              .string();
        } catch (IOException e) {
          e.printStackTrace();
        }
      } else {
        searchText = Constants.QUERY_PREFIX + searchText + Constants.QUERY_SUFFIX;
        try {
          result = client.prepareSearch(Constants.APP_NAME, searchText)
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

  public boolean isInternetAvailable() {
    try {
      InetAddress ipAddr = InetAddress.getByName("google.com");
      return !ipAddr.equals("");
    } catch (Exception e) {
      return false;
    }
  }
}
