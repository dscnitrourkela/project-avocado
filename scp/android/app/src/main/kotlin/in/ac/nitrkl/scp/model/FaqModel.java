package in.ac.nitrkl.scp.model;

import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class FaqModel {
    private String question;
    private String answer;
    private boolean expanded=false;
    private List<String> categories=new ArrayList<>();

    public String getAnswer() {
        return answer;
    }

    public String getQuestion() {
        return question;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setCategories(List<String> categories) {
        this.categories = categories;
    }

    public List<String> getCategories() {
        return categories;
    }

    public FaqModel(String question, String answer, List<String> categories){
        this.question=question;
        this.answer=answer;
        this.categories=categories;
    }

    public boolean isExpanded() {
        return expanded;
    }

    public void setExpanded(boolean expanded) {
        this.expanded = expanded;
    }
}
