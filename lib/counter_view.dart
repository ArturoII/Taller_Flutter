import 'dart:async';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _contador = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print("🟢 initState() → CounterView");
  }

  void _iniciarContador() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        print("⚡ setState() → Incrementar contador");
        setState(() => _contador++);
      });
    }
  }

  void _pausarContador() {
    print("⏸ Pausar contador");
    _timer?.cancel();
  }

  void _reiniciarContador() {
    print("🔄 Reiniciar contador");
    _timer?.cancel();
    setState(() => _contador = 0);
    _iniciarContador();
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 build() → CounterView");
    return Scaffold(
      appBar: AppBar(title: const Text("Contador Automático")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Contador: $_contador",
                style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _iniciarContador,
              child: const Text("Iniciar"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pausarContador,
              child: const Text("Pausar"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _reiniciarContador,
              child: const Text("Reiniciar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    print("🔴 dispose() → CounterView");
    super.dispose();
  }
}
