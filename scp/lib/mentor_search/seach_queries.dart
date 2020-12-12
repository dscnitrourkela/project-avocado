String readMentorDetails = """
query Mentordetails(\$roll : String){
  mentee(rollNumber : \$roll){
  mentor{
    name
    rollNumber
    contact
    email
    prefectDetails{
      name
      coordinatorDetails{
        name
      }
    }
  }
}
}
""";

String readMentees = """
query Mentees(\$roll : String){
  mentor(rollNumber : \$roll){
    name
    mentees{
      name
      rollNumber
      
    }
  }
}
""";
