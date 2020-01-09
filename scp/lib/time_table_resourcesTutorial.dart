abstract class TimeTableResources {
  static final sequence = {
    'tp': {
      'Saturday': ['TA', 'TB', 'TC', 'TD', 'TE',],
      'Sunday': ['TF', 'TB', 'TC', 'TD', 'TE',],
      }
  };

//  static var theoryTutorialAssociation = {
//    'TA': 'SA', 'TB': 'SB', 'TC': 'SC', 'TD': 'TG1', 'TE': 'TG2',
//    'TF': 'TG3', 'TJ': 'SJ', 'TK': 'SK', 'TL': 'SL', 'TM': 'SM'};

  static final slotTime = [
    {'start': '1:30', 'end': '2:30'},
    {'start': '2:30', 'end': '3:30'},
    {'start': '3:30', 'end': '4:30'},
    {'start': '4:30', 'end': '5:30'},
    {'start': '5:30', 'end': '6:30'},
    {'start': '6:30', 'end': '7:30'},
    {'start': '7:30', 'end': '8:30'},
  ];

  static final theory = {
    'Tut1': {
      'TA': 'C Programming',
      'TB': 'Mechanics',
      'TC': 'Physics',
      'TD': 'Mathematics',
      'TE': 'Electrical/Electronics',
      'TF': 'Chemistry',
    },
    'Brid1': {
      'TA': 'C Programming',
      'TB': 'Mechanics',
      'TC': 'Physics',
      'TD': 'Mathematics',
      'TE': 'Electrical/Electronics',
      'TF': 'Chemistry',
    },
  };
}

class PeriodDetails {
  String name;
  String slotTime;
  String location;
  int slotLength;
  String type;
  String locationName;

  PeriodDetails(
      {this.name,
        this.slotTime,
        this.location,
        this.locationName,
        this.slotLength,
        this.type});
}