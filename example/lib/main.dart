import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: VoiceMessageView(
                    width: 0,
                    circlesColor: Colors.black,
                    backgroundColor: Colors.blue,
                    activeSliderColor: Colors.black,
                    notActiveSliderColor: Colors.white,
                    size: 50,
                    playIcon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 35,
                    ),
                    counterTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 11),
                    controller: VoiceController(
                        audioSrc:
                            'https://firebasestorage.googleapis.com/v0/b/vectormgt-develop.appspot.com/o/chat%2Fnow%2F0%3A00%3A03.278000audio1729632650927?alt=media&token=a2dad4ca-c354-467a-bfde-fb0f0cc4e88d',
                        maxDuration:
                            const Duration(seconds: 3, milliseconds: 278)
                                .inMilliseconds,
                        isFile: false,
                        onComplete: () {
                          /// do something on complete
                        },
                        onPause: () {
                          /// do something on pause
                        },
                        onPlaying: () {
                          /// do something on playing
                        },
                        onError: (err) {
                          /// do somethin on error
                        },
                        noiseCount: 72),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
