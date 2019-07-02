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
            {"T2","T3","T4","T5","P1","T6"},
            {"T3","T4","T1","T7","P1","T6"},
            {"T4","T1","T2","T5","P1","T7"}
        };

        String sectionSubcode[][]=new String[][]{
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
        for(int i=0;i<4;i++)
        {
            for(int j=0;j<6;j++)
            {
                String code=tpTimeTable[i][j];
                if(code.substring(0,1).equals("T"))
                {
                    int index=Integer.parseInt(code.substring(1));
                    tpTimeTable[i][j]=sectionSubcode[index-1][theoryNo-1];
                }
            }
        }
        
        for(int i=0; i<4;i++)
        {
            for(int j=0;j<6;j++)
            {
                System.out.print(tpTimeTable[i][j]+" ");
            }
            System.out.println();
        }
    }
}