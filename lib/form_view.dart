import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  final String textoInicial;

  const FormView({super.key, required this.textoInicial});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  String _texto = "";

  @override
  void initState() {
    super.initState();
    print("🟢 FormView initState()");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🔵 FormView didChangeDependencies()");
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 FormView build()");
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Secundaria")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Texto recibido: ${widget.textoInicial}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingrese texto",
                ),
                onChanged: (val) {
                  print("⚡ FormView setState() → TextField");
                  setState(() => _texto = val);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Volver"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("🔴 FormView dispose()");
    super.dispose();
  }
}
