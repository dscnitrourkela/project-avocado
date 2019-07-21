abstract class TimeTableResources {
  static final tpSequence = {
    'Monday': ['TA', 'TB', 'TC', 'TE', 'PA', 'PA', 'PA', 'TF', 'ZA'],
    'Tuesday': ['TB', 'TC', 'TD', 'TE', 'PB', 'PB', 'PB', 'TF', 'ZB'],
    'Wednesday': ['', 'PX', 'PX', 'PX', 'TG1', 'SA', 'SB', 'SC', 'ZA',
      'SM1', 'SJ1', 'SK1', 'SL1', '', 'PY', 'PY', 'PY', ''],
    'Thursday': ['TC', 'TD', 'TA', 'TG2', 'PC', 'PC', 'PC', 'TF', 'ZC'],
    'Friday': ['TD', 'TA', 'TB', 'TE', 'PD', 'PD', 'PD', 'TG3', 'ZA']
  };

  static final sequence = {
    'tp': {
      'Monday': ['TA', 'TB', 'TC', 'TE', 'PA', 'PA', 'PA', 'TF', 'ZA'],
      'Tuesday': ['TB', 'TC', 'TD', 'TE', 'PB', 'PB', 'PB', 'TF', 'ZB'],
      'Wednesday': ['', 'PX', 'PX', 'PX', 'TG1', 'SA', 'SB', 'SC', 'ZA',
        'SM1', 'SJ1', 'SK1', 'SL1', '', 'PY', 'PY', 'PY', ''],
      'Thursday': ['TC', 'TD', 'TA', 'TG2', 'PC', 'PC', 'PC', 'TF', 'ZC'],
      'Friday': ['TD', 'TA', 'TB', 'TE', 'PD', 'PD', 'PD', 'TG3', 'ZA']
    },
    'pt': {
      'Monday': ['PE', 'PE', 'PE', 'TE', 'TJ', 'TK', 'TL', 'TF', 'ZA'],
      'Tuesday': ['PF', 'PF', 'PF', 'TE', 'TK', 'TL', 'TM', 'TF', 'ZB'],
      'Wednesday': ['', 'PX', 'PX', 'PX', 'TG1', 'SA', 'SB', 'SC', 'ZA',
        'SM1', 'SJ1', 'SK1', 'SL1', '', 'PY', 'PY', 'PY', ''],
      'Thursday': ['PG', 'PG', 'PG', 'TG2', 'TL', 'TM', 'TJ', 'TF', 'ZC'],
      'Friday': ['PH', 'PH', 'PH', 'TE', 'TM', 'TJ', 'TK', 'TG3', 'ZA']
    }
  };

//  static var theoryTutorialAssociation = {
//    'TA': 'SA', 'TB': 'SB', 'TC': 'SC', 'TD': 'TG1', 'TE': 'TG2',
//    'TF': 'TG3', 'TJ': 'SJ', 'TK': 'SK', 'TL': 'SL', 'TM': 'SM'};

  static final slotTime = [
    {'start': '8:00', 'end': '8:55'},
    {'start': '9:00', 'end': '9:55'},
    {'start': '10:00', 'end': '10:55'},
    {'start': '11:05', 'end': '12:00'},
    {'start': '1:15', 'end': '2:10'},
    {'start': '2:15', 'end': '3:10'},
    {'start': '3:15', 'end': '4:10'},
    {'start': '4:20', 'end': '5:15'},
    {'start': '5:20', 'end': '6:15'},
  ];

  static final theory = {
    'A': {
      'TA': 'Physics-I',
      'TB': 'Engineering Mechanics',
      'TC': 'Mathematics-I',
      'TD': 'Basic Electrical Engineering',
      'TF': 'Chemistry',
      'SA': 'Physics-Tutorial',
      'SC': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'B': {
      'TA': 'Physics-I',
      'TB': 'Engineering Mechanics',
      'TC': 'Mathematics-I',
      'TD': 'Basic Electrical Engineering',
      'TF': 'Chemistry',
      'SA': 'Physics-Tutorial',
      'SC': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'C': {
      'TA': 'Engineering Mechanics',
      'TB': 'Physics-I',
      'TC': 'Basic Electrical Engineering',
      'TD': 'Mathematics-I',
      'TF': 'Chemistry',
      'SB': 'Physics-Tutorial',
      'TG1': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'D': {
      'TA': 'Engineering Mechanics',
      'TB': 'Physics-I',
      'TC': 'Basic Electrical Engineering',
      'TD': 'Mathematics-I',
      'TF': 'Chemistry',
      'SB': 'Physics-Tutorial',
      'TG1': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'E': {
      'TE': 'Biology',
      'TJ': 'Mathematics-I',
      'TK': 'Physics-I',
      'TL': 'Basic Electronics Engineering',
      'TM': 'Environment And Safety Engineering',
      'TF': 'Communicative English',
      'SJ1': 'Mathematics-Tutorial',
      'SK1': 'Physics-Tutorial',
    },
    'F': {
      'TE': 'Biology',
      'TJ': 'Mathematics-I',
      'TK': 'Physics-I',
      'TL': 'Basic Electronics Engineering',
      'TM': 'Environment And Safety Engineering',
      'TF': 'Communicative English',
      'SJ1': 'Mathematics-Tutorial',
      'SK1': 'Physics-Tutorial',
    },
    'G': {
      'TE': 'Environment And Safety Engineering',
      'TJ': 'Basic Electronics Engineering',
      'TK': 'Biology',
      'TL': 'Mathematics-I',
      'TM': 'Physics-I',
      'TG': 'Communicative English',
      'SL1': 'Mathematics-Tutorial',
      'SM1': 'Physics-Tutorial'
    },
    'H': {
      'TE': 'Environment And Safety Engineering',
      'TJ': 'Basic Electronics Engineering',
      'TK': 'Biology',
      'TL': 'Mathematics-I',
      'TM': 'Physics-I',
      'TG': 'Communicative English',
      'SL1': 'Mathematics-Tutorial',
      'SM1': 'Physics-Tutorial'
    },
  };

  static final practical = {
    'P1': {'PA': 'PL', 'PB': 'BP', 'PD': 'WP'},
    'P2': {'PB': 'PL', 'PC': 'BP', 'PX': 'WP'},
    'P3': {'PC': 'PL', 'PD': 'BP', 'PA': 'WP'},
    'P4': {'PD': 'PL', 'PX': 'BP', 'PB': 'WP'},
    'P5': {'PX': 'PL', 'PA': 'BP', 'PC': 'WP'},
    'P6': {'PE': 'CL', 'PG': 'ED'},
    'P7': {'PF': 'CL', 'PH': 'ED'},
    'P8': {'PG': 'CL', 'PY': 'ED'},
    'P9': {'PH': 'CL', 'PE': 'ED'},
    'P10': {'PY': 'CL', 'PF': 'ED'},
  };

  static final practicalDetails = {
    'PL': {'name': 'Physics Laboratory', 'location': 'https://www.google.com/maps/search/?api=1&query=22.2523901,84.9010777', 'locationName': 'Main Building'},
    'BP': {'name': 'Basic Programming', 'location': 'https://www.google.com/maps/search/?api=1&query=22.2513332,84.9048918', 'locationName': 'LA1'},
    'WP': {'name': 'Workshop Practices', 'location': 'https://www.google.com/maps/search/?api=1&query=22.2526002,84.9029979', 'locationName': 'Central Workshop'},
    'CL': {'name': 'Chemistry Laboratory', 'location': 'https://www.google.com/maps/search/?api=1&query=22.2523901,84.9010777', 'locationName': 'Main Building'},
    'ED': {'name': 'Engineering Drawing', 'location': 'https://www.google.com/maps/search/?api=1&query=22.2513332,84.9048918', 'locationName': 'LA1'},
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
