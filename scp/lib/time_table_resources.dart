abstract class TimeTableResources {
  static final tpSequence = {
    'monday' : ['TA', 'TB', 'TC', 'TE', 'PA', 'PA', 'PA', 'TF', 'ZA'],
    'tuesday': ['TB', 'TC', 'TD', 'TE', 'PB', 'PB', 'PB', 'TF', 'ZB'],
    'wednesday': ['', 'PX', 'PX', 'PX', 'TG1', 'SA', 'SB', 'SC', 'ZA'],
    'thursday': ['TC', 'TD', 'TA', 'TG2', 'PC', 'PC', 'PC', 'TF', 'ZC'],
    'friday': ['TD', 'TA', 'TB', 'TE', 'PD', 'PD', 'PD', 'TG3', 'ZA']
  };

//  static var theoryTutorialAssociation = {
//    'TA': 'SA', 'TB': 'SB', 'TC': 'SC', 'TD': 'TG1', 'TE': 'TG2',
//    'TF': 'TG3', 'TJ': 'SJ', 'TK': 'SK', 'TL': 'SL', 'TM': 'SM'};

  static final theory = {
    'A': {
      'TA': 'Physics-I', 'TB': 'Engineering Mechanics',
      'TC': 'Mathematics-I', 'TD': 'Basic Electrical Engineering',
      'TF': 'Chemistry', 'SA': 'Physics-Tutorial', 'SC': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'B': {
      'TA': 'Physics-I', 'TB': 'Engineering Mechanics',
      'TC': 'Mathematics-I', 'TD': 'Basic Electrical Engineering',
      'TF': 'Chemistry', 'SA': 'Physics-Tutorial', 'SC': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'C': {
      'TA': 'Engineering Mechanics', 'TB': 'Physics-I',
      'TC': 'Basic Electrical Engineering', 'TD': 'Mathematics-I',
      'TF': 'Chemistry', 'SB': 'Physics-Tutorial', 'TG1': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
    'D': {
      'TA': 'Engineering Mechanics', 'TB': 'Physics-I',
      'TC': 'Basic Electrical Engineering', 'TD': 'Mathematics-I',
      'TF': 'Chemistry', 'SB': 'Physics-Tutorial', 'TG1': 'Mathematics-Tutorial',
      'TG3': 'Chemistry-Tutorial'
    },
  };

  static final practical = {
    'P1': {'PA': 'Physics Laboratory', 'PB': 'Basic Programming', 'PD': 'Workshop Practices'},
    'P2': {'PB': 'Physics Laboratory', 'PC': 'Basic Programming', 'PX': 'Workshop Practices'},
    'P3': {'PC': 'Physics Laboratory', 'PD': 'Basic Programming', 'PA': 'Workshop Practices'},
    'P4': {'PD': 'Physics Laboratory', 'PX': 'Basic Programming', 'PB': 'Workshop Practices'},
    'P5': {'PX': 'Physics Laboratory', 'PA': 'Basic Programming', 'PC': 'Workshop Practices'},
  };
}