import 'package:flutter/material.dart';
import 'form_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _HomeState();
}

class _HomeState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);
  bool _activo = false;
  double _valorSlider = 0;

  @override
  void initState() {
    super.initState();
    print("🟢 initState() ejecutado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🔵 didChangeDependencies() ejecutado");
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 build() ejecutado");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Principal"),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: "Lista"),
            Tab(text: "Opciones"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(6, (i) => _buildGridItem(i)),
          ),
          _buildOptions(),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) => InkWell(
        onTap: () {
          print("➡ Navegando a FormView con Elemento $index");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FormView(textoInicial: "Elemento $index"),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            "Elemento $index",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );

  Widget _buildOptions() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Activar opción:", style: TextStyle(fontSize: 18)),
            Switch(
              value: _activo,
              onChanged: (v) {
                print("⚡ setState() ejecutado - Switch");
                setState(() => _activo = v);
              },
            ),
            Text(
              _activo ? "Opción activada" : "Opción desactivada",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Valor del Slider:", style: TextStyle(fontSize: 18)),
            Slider(
              value: _valorSlider,
              min: 0,
              max: 100,
              divisions: 10,
              label: _valorSlider.round().toString(),
              onChanged: (v) {
                print("⚡ setState() ejecutado - Slider");
                setState(() => _valorSlider = v);
              },
            ),
            Text("Valor actual: ${_valorSlider.round()}",
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      );

  @override
  void dispose() {
    _tabs.dispose();
    print("🔴 dispose() ejecutado");
    super.dispose();
  }
}
