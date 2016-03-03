import 'dart:io';
import 'package:sqljocky/sqljocky.dart';

List information=new List();
var question;

main() async {
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
  print("Serving at ${server.address}:${server.port}");

  connectDB();

  await for (var request in server) {
    HttpResponse res = request.response;
    addCorsHeaders(res);
    res
      ..headers.contentType = new ContentType("application", "json", charset: "utf-8")
      ..write(information);
    res.close();
  }




}

void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}
connectDB() async{
  var pool = new ConnectionPool(host: 'localhost', port: 3306, user: 'root', password: '1234', db: 'stu_10130340101', max: 8);
  var results = await pool.query('select * from exercise where id=1;');
  results.forEach((row) {
    print(' opt1: ${row[3]},opt2: ${row[4]},opt3: ${row[5]},opt4:${row[6]},rightopt_id:${row[2]}');
    information.add('"${row[1]}","  ${row[3]}"," ${row[4]}","${row[5]}","${row[6]}","${row[2]}"');
    question='${row[1]}';
  });
}

/*var pool = new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340101', max: 5);
  var results = await pool.query('create table stu1(num int,name char(10));');*/