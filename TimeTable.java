import java.io.*;
public class TimeTable
{
    public static void main(String args[])throws IOException
    {
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("Enter Theory Section[A-H]");
        String theorySection=in.readLine();
        theorySection =theorySection.toUpperCase();
        System.out.println("Enter Practical Section[P1-P10]");
        String practicalSection=in.readLine();
        practicalSection=practicalSection.toUpperCase();
        int theoryNo, practicalNo;
        theoryNo=theorySection.charAt(0)-64;
        practicalNo=Integer.parseInt(practicalSection.substring(practicalSection.indexOf('P')+1));
        System.out.println("TheoryNo"+theoryNo);
        System.out.println("PracticalNo"+practicalNo);

        String tpTimeTable[][]=new String[][]{
            {"T1","T2","T3","T5","P1","T6"},
            {"T2","T3","T4","T5","P2","T6"},
            {"T3","T4","T1","T7","P3","T6"},
            {"T4","T1","T2","T5","P4","T7"}
        };

        String ptTimeTable[][]=new String[][]{
            {"P5","T5","T8","T9","T10","T6"},
            {"P6","T5","T9","T10","T11","T6"},
            {"P7","T7","T10","T11","T8","T6"},
            {"P8","T5","T11","T8","T9","T7"}
        };

        String theorySubcode[][]=new String[][]{
            {"","","","","Physics","Physics","Mechanics","Mechanics"},
            {"","","","","Mechanics","Mechanics","Physics","Physics"},
            {"","","","","Maths","Maths","Electrical","Electrical"},
            {"","","","","Electrical","Electrical","Maths","Maths"},
            {"Biology","Biology","EVS","EVS","","","",""},
            {"English","English","","","Chemistry","Chemistry","Chemistry","Chemistry"},
            {"","","English","English","","","",""},
            {"Maths","Maths","Electronics","Electronics","","","",""},
            {"Physics","Physics","Biology","Biology","","","",""},
            {"Electronics","Electronics","Maths","Maths","","","",""},
            {"EVS","EVS","Physics","Physics","","","",""}
        };

        String practicalSubcode[][]=new String[][]{
            {"","","","","","Physics","","Workshop","","Programming"},
            {"","","","","","Programming","Physics","","Workshop",""},
            {"","","","","","","Programming","Physics","","Workshop"},
            {"","","","","","Workshop","","Programming","Physics",""},
            {"Chemistry","","","Engineering Drawing","","","","","",""},
            {"","Chemistry","","","Engineering Drawing","","","","",""},
            {"Engineering Drawing","","Chemistry","","","","","","",""},
            {"","Engineering Drawing","","Chemistry","","","","","",""},
            {"","","","","","","Workshop","","Programming","Physics"},
            {"","","Engineering Drawing","","Chemistry","","","","",""}
        };

        for(int i=0;i<4;i++)
        {
            for(int j=0;j<6;j++)
            {
                if(theoryNo>4)
                {
                    String code=tpTimeTable[i][j];
                    if(code.substring(0,1).equals("T"))
                    {
                        int index=Integer.parseInt(code.substring(1));
                        if(theorySubcode[index-1][theoryNo-1].equals(""))
                        {
                            tpTimeTable[i][j]="<Classoff>";
                        }
                        else
                        {
                            tpTimeTable[i][j]=theorySubcode[index-1][theoryNo-1];
                        }
                    }
                    else if(code.substring(0,1).equals("P"))
                    {
                        int index=Integer.parseInt(code.substring(1));
                        if(practicalSubcode[index-1][practicalNo-1].equals(""))
                        {
                            tpTimeTable[i][j]="<Laboff>";
                        }
                        else
                        {
                            tpTimeTable[i][j]=practicalSubcode[index-1][practicalNo-1];
                        }
                    }
                }
                else
                {
                    String code=ptTimeTable[i][j];
                    if(code.substring(0,1).equals("T"))
                    {
                        int index=Integer.parseInt(code.substring(1));
                        if(theorySubcode[index-1][theoryNo-1].equals(""))
                        {
                            ptTimeTable[i][j]="<Classoff>";
                        }
                        else
                        {
                            ptTimeTable[i][j]=theorySubcode[index-1][theoryNo-1];
                        }
                    }
                    else if(code.substring(0,1).equals("P"))
                    {
                        int index=Integer.parseInt(code.substring(1));
                        if(practicalSubcode[index-1][practicalNo-1].equals(""))
                        {
                            ptTimeTable[i][j]="<Laboff>";
                        }
                        else
                        {
                            ptTimeTable[i][j]=practicalSubcode[index-1][practicalNo-1];
                        }
                    }

                }
            }
        }
        
        for(int i=0; i<4;i++)
        {
            System.out.print("DAY"+(i+1)+" :");
            for(int j=0;j<6;j++)
            {
                if(theoryNo>4)
                System.out.print(tpTimeTable[i][j]+" ");
                else
                System.out.print(ptTimeTable[i][j]+" ");
            }
            System.out.println();
        }
    }
}