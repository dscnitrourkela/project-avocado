package in.ac.nitrkl.scp.adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.Space;
import android.widget.TextView;

import java.util.List;

import in.ac.nitrkl.scp.model.FaqModel;
import in.ac.nitrkl.scp.scp.R;

public class FaqAdapter extends RecyclerView.Adapter<FaqAdapter.ViewHolder> {

    private List<FaqModel> faqModels;
    private Context context;

    public FaqAdapter(List<FaqModel> faqModels, Context context){
        this.faqModels=faqModels;
        this.context=context;
    }
    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
       View v=LayoutInflater.from(parent.getContext())
               .inflate(R.layout.qa_card,parent,false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        final FaqModel faqModel=faqModels.get(position);
        holder.q.setText(faqModel.getQuestion());
        holder.a.setText(faqModel.getAnswer());
        boolean expanded=faqModel.isExpanded();
        holder.a.setVisibility(expanded?View.VISIBLE:View.GONE);
        holder.space.setVisibility(expanded?View.VISIBLE:View.GONE);
        holder.itemView.setOnClickListener(v->{
            faqModel.setExpanded(!faqModel.isExpanded());
            notifyItemChanged(position);

                }
        );
    }

    @Override
    public int getItemCount() {
        return faqModels.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder{
public TextView q,a;
public Space space;

        public ViewHolder(View itemView) {
            super(itemView);
            q=(TextView)itemView.findViewById(R.id.question);
            a=(TextView)itemView.findViewById(R.id.answer);
            space=(Space)itemView.findViewById(R.id.qa_space);
        }
    }
}
