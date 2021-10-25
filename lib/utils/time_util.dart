import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getTimeMess(Timestamp sendTime) {
  var Now = (new DateTime.now());
  var differenceTime = sendTime.toDate().difference(Now).inMinutes.abs();
  if (differenceTime < 1)
    return 'vừa xong';
  else if (differenceTime < 60) return "$differenceTime phút trước";
  bool isSameWeek = getWeekOfYear(Now) == getWeekOfYear(sendTime.toDate());

  var format = new DateFormat('yyyy-MM-dd');

  String now = DateFormat('yyyy-MM-dd').format(Now);
  // print("hôm nay là $now");

  String past = format.parse(sendTime.toDate().toString()).toString();
  int n = past.length;
  int k = -1;
  for (int j = 0; j < n; j++) {
    if (past[j] == " ") {
      k = j;
      break;
    }
  }
  past = past.substring(0, k);
  if (past == now) {
    format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String s = format.parse(sendTime.toDate().toString()).toString();
    n = s.length;
    int k1 = -1, k2 = -1;
    for (int j = 0; j < n; j++) {
      if (s[j] == " ") {
        k1 = j;
      }
      if (s[j] == ":") {
        k2 = j;
      }
    }
    //print("hôm nay là ssss $s");
    s = s.substring(0, k2);
    s = s.substring(k1, k2);
    //print("hôm nay là ssss $s");
    return s;
  } else if (isSameWeek) {
    DateTime s = format.parse(sendTime.toDate().toString());
    String a = DateFormat('E').format(s);
    if (a == "Mon")
      return "T.2";
    else if (a == "Tue")
      return "T.3";
    else if (a == "Wed")
      return "T.4";
    else if (a == "Thu")
      return "T.5";
    else if (a == "Fri")
      return "T.6";
    else if (a == "Sat")
      return "T.7";
    else
      return "CN";
  }else{
    return DateFormat('dd-MM-yyyy').format(sendTime.toDate());
  }
}

getWeekOfYear(DateTime time){
  int d=DateTime.parse("${time.year}-01-01").millisecondsSinceEpoch;
  int t= time.millisecondsSinceEpoch;
  double daydiff= (t- d)/(1000 * (3600 * 24));
  double week= daydiff/7;
  return(week.ceil());
}
