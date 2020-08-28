import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  // TODO: insert your own file paths here
  final paths = [
    '/storage/emulated/0/ ... /Beartooth/Aggressive/01 - Aggressive.mp3',
    '/storage/emulated/0/ ... /Beartooth/Aggressive/02 - Hated.mp3',
    '/storage/emulated/0/ ... /Beartooth/Aggressive/03 - Loser.mp3',
    '/storage/emulated/0/ ... /Beartooth/Aggressive/04 - Fair Weather Friend.mp3',
  ];

  void _loadPlaylistandPlay() async {
    if (await Permission.storage.request().isGranted) {
      await audioPlayer.load(ConcatenatingAudioSource(
          children:
              paths.map((String p) => AudioSource.uri(Uri.file(p))).toList()));

      await audioPlayer.seek(Duration(milliseconds: 0), index: 1);
      audioPlayer.play();
    }
  }

  @override
  void initState() {
    audioPlayer.currentIndexStream.listen((event) => print('index: $event'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadPlaylistandPlay,
        tooltip: 'Play',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
