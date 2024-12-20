import 'package:flashlight_plus/flashlight_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _flashLightPlus = FlashlightPlus();

  String _title = "Check Torch Available";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flashlight Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () async {
                  final value = await _flashLightPlus.isAvailableTorch;
                  setState(() {
                    _title = value ? "Torch Available" : "Torch Not Available";
                  });
                },
                child: const Text("Checking Torch"),
              ),
              const SizedBox(
                height: 24,
              ),
              FilledButton(
                onPressed: () {
                  _flashLightPlus.turnOn();
                },
                child: const Text("Turn on"),
              ),
              const SizedBox(
                height: 24,
              ),
              FilledButton(
                onPressed: () {
                  _flashLightPlus.turnOff();
                },
                child: const Text("Turn off"),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
