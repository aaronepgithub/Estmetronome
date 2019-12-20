import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('Global Val ' + globals.globalSecondsPerCycle.toString());
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.pink],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: new MyTimerPage(
            titleStyle: titleStyle, trailingStyle: trailingStyle),
      ),
    );
  }
}

class MyTimerPage extends StatefulWidget {
  const MyTimerPage({
    Key key,
    @required this.titleStyle,
    @required this.trailingStyle,
  }) : super(key: key);

  final TextStyle titleStyle;
  final TextStyle trailingStyle;

  @override
  _MyTimerPageState createState() => _MyTimerPageState();
}

class _MyTimerPageState extends State<MyTimerPage> {
  Stopwatch watch = new Stopwatch();
  Timer timer;

  @override
void dispose() {
 print('dispose');
 watch.stop();
 super.dispose();
}

  String elapsedTime = '00:00';
  String cycleTimeRemaining = globals.globalSecondsPerCycle.toString();
  
  String secondsPerCycle = globals.globalSecondsPerCycle.toString();
  String cyclesCompleted = '0';

  double dblElapsedTimeInMilli;
  double dblCycleTimeRemaining;

  double dblSecondsPerCycle = globals.globalSecondsPerCycle;
  double dblCyclesCompleted = 0.0;

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);

        dblCycleTimeRemaining =
            ((dblSecondsPerCycle * 1000) * dblCyclesCompleted) -
                watch.elapsedMilliseconds;
        cycleTimeRemaining =
            (dblCycleTimeRemaining / 1000 + 1).truncate().toString();

        //Test for new Cycle
        if (watch.elapsedMilliseconds >=
            ((dblSecondsPerCycle * 1000) * (dblCyclesCompleted))) {
          dblCyclesCompleted++;
          cyclesCompleted = (dblCyclesCompleted - 1).truncate().toString();
          myPlaySound();
        }
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    dblSecondsPerCycle = globals.globalSecondsPerCycle;
    secondsPerCycle = globals.globalSecondsPerCycle.toString();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text("Time Left In Cycle", style: widget.titleStyle),
                trailing: Text(cycleTimeRemaining,
                    style: widget.trailingStyle),
              ),
            ),
            flex: 1,
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text("Cycles Complete", style: widget.titleStyle),
                trailing: Text(cyclesCompleted, style: widget.trailingStyle),
              ),
            ),
            flex: 1,
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text("Time To Limitation", style: widget.titleStyle),
                trailing: Text(elapsedTime, style: widget.trailingStyle),
              ),
            ),
            flex: 1,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.deepPurple.withOpacity(0.8),
                  textColor: Colors.white,
                  onPressed: startWatch,
                  child: Text("Start"),
                ),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.deepPurple.withOpacity(0.8),
                  textColor: Colors.white,
                  onPressed: stopWatch,
                  child: Text("Stop"),
                ),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.deepPurple.withOpacity(0.8),
                  textColor: Colors.white,
                  onPressed: resetWatch,
                  child: Text("Reset"),
                )
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  startWatch() {
    print('startWatch');
    if (!watch.isRunning) {
      watch.start();
      dblSecondsPerCycle = double.parse(secondsPerCycle);
      timer = new Timer.periodic(new Duration(milliseconds: 100), updateTime);
    }
  }

  stopWatch() {
    print('stopWatch');
    if (watch.isRunning) {
      watch.stop();
      setTime();
    }
  }

  resetWatch() {
    print('resetWatch');
    watch.reset();
    dblCyclesCompleted = 0;
    dblCycleTimeRemaining = 0;
    setState(() {
      cyclesCompleted = '0';
        cycleTimeRemaining = globals.globalSecondsPerCycle.toString();
    });
    setTime();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  myPlaySound() {
    // FlutterRingtonePlayer.playNotification();

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.triTone,
      looping: false,
      volume: 0.5,
    );
  }



  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String millifracStr = (milliseconds % 10).toStringAsFixed(0);

    if (watch.isRunning) {
      return "$minutesStr:$secondsStr";
    } else {
      return "$minutesStr:$secondsStr:$millifracStr";
    }
  }

}
