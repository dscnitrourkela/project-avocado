package in.ac.nitrkl.scp.model;

public class FaqModel {
    private String question;
    private String answer;
    private boolean expanded=false;

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

    public FaqModel(String question,String answer){
        this.question=question;
        this.answer=answer;
    }

    public boolean isExpanded() {
        return expanded;
    }

    public void setExpanded(boolean expanded) {
        this.expanded = expanded;
    }
}
