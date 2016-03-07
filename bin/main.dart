import 'dart:io';
import 'dart:convert';
import 'package:sqljocky/sqljocky.dart';

List information=new List();
var question;
String exe_id;
List reinformation=new List();

main() async {
  connectDB();
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print("Serving at ${server.address}:${server.port}");
  server.listen((HttpRequest request) async {
    if (request.uri.path == "/first") {     //响应index.dart
      await first_exe(request);
    }
    if (request.uri.path == "/next" ) {     //tea.dart中显示教师姓名和课程名称
      await next_exe(request);
    }
  });

}
first_exe(HttpRequest request) async{
  HttpResponse res = request.response;
  addCorsHeaders(res);
  res
  ..headers.contentType = new ContentType("application", "json", charset: "utf-8")
  ..write(information);
  res.close();
}

next_exe(HttpRequest request) async{
  String name;
  try {
    name = await request.transform(UTF8.decoder.fuse(JSON.decoder)).first;
  } catch (e) {
    print('Error:$e');
  }
  var pool = new ConnectionPool(host: '52.193.39.90', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340101_2', max: 8);
  var results = await pool.query('select * from exercise where id='+name+';');
  results.forEach((row) {
    reinformation.clear();
    reinformation.add("${row[1]}");//,"${row[3]}"," ${row[4]}","${row[5]}","${row[6]}","${row[2]}"
    reinformation.add("${row[3]}");
    reinformation.add("${row[4]}");
    reinformation.add("${row[5]}");
    reinformation.add("${row[6]}");
    reinformation.add("${row[2]}");
    print(reinformation);
  });
  HttpResponse res = request.response;
  addCorsHeaders(res);
  res.headers.contentType = new ContentType("application", "json", charset: "utf-8");
  request.response.write(JSON.encode(reinformation));
  request.response.close();
  /*
  addCorsHeaders(request.response);
  var studentnumber,studentab,stuab;
  studentnumber = selectstu[0];
  studentab = selectstu[2];
  int stu_ab1;
  stu_ab1 = int.parse(studentab);
  stu_ab1 = stu_ab1 + 1;
  print(stu_ab1);
  pool.query(
      'UPDATE SC,C SET SC.OB = $stu_ab1 WHERE SC.CNUM = C.CNUM AND C.CNAME = "$coursename" AND SC.SNUM = "$studentnumber"'
  );
  request.response.write(JSON.encode(stu_ab1));
  request.response.close();
   */
}


void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}

connectDB() async{
    var pool = new ConnectionPool(host: '52.193.39.90', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340101_2', max: 8);
    var results = await pool.query('select * from exercise where id=1;');
    results.forEach((row) {
      information.clear();
      information.add('"${row[1]}","${row[3]}"," ${row[4]}","${row[5]}","${row[6]}","${row[2]}"');
      print(information);
      question='${row[1]}';
    });

}

/*var pool = new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340101', max: 5);
  var results = await pool.query('create table stu1(num int,name char(10));');*/