import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/providers/firebase_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FirebaseMsg(),
        child: MaterialApp(
          home: MyHome(),
        ));
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  FirebaseMsg firebasemsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasemsg = Provider.of<FirebaseMsg>(context, listen: false);
    firebasemsg.configure();
  }

  @override
  Widget build(BuildContext context) {
    // firebasemsg = Provider.of<FirebaseMsg>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer(
          builder: (_, FirebaseMsg msg, __) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text("Firebase notification receiver"),
                  FutureBuilder(
                    future: msg.getToken(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        print(snapshot.data);
                        return Text("Token: " + snapshot.data);
                      } else {
                        return Text("Token: null");
                      }
                    },
                  ),
                  Text(
                    "onMessage: => " + msg.onMessageString ?? "null",
                    style: TextStyle(backgroundColor: Colors.greenAccent),
                  ),
                  Text("onLaunch: => " + msg.onLaunchString ?? "null",style: TextStyle(backgroundColor: Colors.blueAccent,color: Colors.white,),),
                  Text("onBackground: => " + msg.onBackgroundString ?? "null",style: TextStyle(backgroundColor: Colors.amberAccent,color: Colors.black,),),
                  Text("onResume: => " + msg.onResumeMsg ?? "null",style: TextStyle(backgroundColor: Colors.redAccent,color: Colors.white),),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
