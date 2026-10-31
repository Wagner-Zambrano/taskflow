import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const studentName = 'Wagner Zambrano';
    const pendingTasks = 10;
    const courseName = 'Desarrollo de aplicaciones móviles';

    // Mensaje motivacional
    const motivationalMessage =
        '¡Organiza tus tareas, alcanza tus metas y logra tus objetivos!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono que representa la aplicación
            const Icon(
              Icons.task_alt,
              size: 56,
            ),

            const SizedBox(height: 24),

            // Saludo al estudiante
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            // Mensaje motivacional debajo del saludo
            Text(
              motivationalMessage,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: 12),

            Text('Bienvenido/a a $courseName.'),

            const SizedBox(height: 32),

            // Tarjeta de tareas pendientes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
