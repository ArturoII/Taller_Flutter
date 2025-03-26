import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class HeavyTaskView extends StatefulWidget {
  const HeavyTaskView({super.key});

  @override
  State<HeavyTaskView> createState() => _HeavyTaskViewState();
}

class _HeavyTaskViewState extends State<HeavyTaskView> {
  bool _ejecutando = false;

  @override
  void initState() {
    super.initState();
    print("🟢 initState() → HeavyTaskView");
  }

  void _iniciarTareaPesada() async {
    if (_ejecutando) return;

    setState(() => _ejecutando = true);
    print("⚙️ Ejecutando Isolate");

    final result = await _ejecutarEnIsolate();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Resultado: $result")),
    );

    setState(() => _ejecutando = false);
  }

  Future<int> _ejecutarEnIsolate() async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_tareaPesada, receivePort.sendPort);

    return await receivePort.first as int;
  }

  static void _tareaPesada(SendPort sendPort) {
    int suma = 0;
    for (int i = 1; i <= 2000000; i++) {
      suma += i;
    }
    sendPort.send(suma);
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 build() → HeavyTaskView");
    return Scaffold(
      appBar: AppBar(title: const Text("Tarea Pesada (Isolate)")),
      body: Center(
        child: ElevatedButton(
          onPressed: _ejecutando ? null : _iniciarTareaPesada,
          child: const Text("Ejecutar tarea"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("🔴 dispose() → HeavyTaskView");
    super.dispose();
  }
}
