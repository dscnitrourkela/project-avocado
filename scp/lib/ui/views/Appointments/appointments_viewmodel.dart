import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:scp/firebase/firebaseDBHandler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

bool isBookingAnonymously;

class AppointmentViewModel extends BaseViewModel {
  double queryWidth;
  double textScaleFactor;
  String counselDay, counselorName, psychName, psychDay;
  StreamSubscription<Event> _onCounselChangedSubscription,
      _onPsychChangedSubscription;

  ScpDatabase scpDatabase;
  String psychDate, counselDate;

  void initState() {
    getDate();

    scpDatabase = ScpDatabase();

    notifyListeners();
  }

  void getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    psychDate = prefs.getString('psychDate');
    counselDate = prefs.getString('counselDate');
    notifyListeners();
  }

  Future<RemoteConfig> setupRemoteConfig() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    counselDay = remoteConfig.getString('counsel_day');
    counselorName = remoteConfig.getString('counselor_name');
    psychName = remoteConfig.getString('psych_name');
    psychDay = remoteConfig.getString('psych_day');
    await scpDatabase.init();
    _onCounselChangedSubscription =
        ScpDatabase.counselRef.onChildChanged.listen(_onSlotsUpdated);
    _onPsychChangedSubscription =
        ScpDatabase.psychRef.onChildChanged.listen(_onSlotsUpdated);
    return remoteConfig;
  }

  void _onSlotsUpdated(Event event) async {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _onCounselChangedSubscription.cancel();
    _onPsychChangedSubscription.cancel();
  }
}
