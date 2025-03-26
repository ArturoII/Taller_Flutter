import 'package:flutter/material.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  late Future<List<String>> _futureEstudiantes;

  @override
  void initState() {
    super.initState();
    print("🟢 initState() → StudentListView");
    _futureEstudiantes = _cargarEstudiantes();
  }

  Future<List<String>> _cargarEstudiantes() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      "Ana López",
      "Carlos Pérez",
      "María Torres",
      "Luis Rodríguez",
      "Camila Mendoza",
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 build() → StudentListView");
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Estudiantes")),
      body: FutureBuilder<List<String>>(
        future: _futureEstudiantes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final estudiantes = snapshot.data!;
            return ListView.builder(
              itemCount: estudiantes.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(estudiantes[index]),
              ),
            );
          } else {
            return const Center(child: Text("Error al cargar datos"));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    print("🔴 dispose() → StudentListView");
    super.dispose();
  }
}
