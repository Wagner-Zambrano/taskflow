import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

// Aplicación principal
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Pantalla principal de TaskFlow
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  // Datos del estudiante
  final String studentName = 'Wagner Zambrano';

  // Variables de estado
  int pendingTasks = 10;
  int completedTasks = 0;

  // Meta diaria
  static const int dailyGoal = 5;

  // Mensaje motivacional
  final String motivationalMessage =
      '¡Organiza tus tareas, alcanza tus metas y logra tus objetivos!';

  // Función para agregar tareas
  void addTask() {
    setState(() {
      pendingTasks++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Tarea agregada correctamente!'),
      ),
    );
  }

  // Función para completar tareas
  void completeTask() {
    if (pendingTasks > 0) {
      setState(() {
        pendingTasks--;

        // No superar la meta diaria
        if (completedTasks < dailyGoal) {
          completedTasks++;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Tarea completada!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    // Mensaje según las tareas pendientes
    final String statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(

      // Barra superior
      appBar: AppBar(
        title: const Text(
          'TaskFlow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      // Contenido principal
      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Icono de TaskFlow
            const Icon(
              Icons.task_alt,
              size: 60,
              color: Colors.indigo,
            ),

            const SizedBox(height: 20),

            // Saludo
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),

            const SizedBox(height: 12),

            // Mensaje motivacional
            Text(
              motivationalMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Bienvenido a tu panel de organización.',
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),

            // Estado de las tareas
            Text(
              statusMessage,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // Tarjeta de tareas pendientes
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    const Icon(
                      Icons.pending_actions,
                      size: 45,
                      color: Colors.indigo,
                    ),

                    const SizedBox(width: 20),

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tareas pendientes',
                          style: TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '$pendingTasks',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Tarjeta de tareas completadas
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 45,
                      color: Colors.green,
                    ),

                    const SizedBox(width: 20),

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Completadas hoy',
                          style: TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '$completedTasks de $dailyGoal',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botón para agregar tarea
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addTask,
                icon: const Icon(Icons.add),
                label: const Text('Agregar tarea'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botón para completar tarea
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed:
                    pendingTasks > 0 ? completeTask : null,
                icon: const Icon(
                  Icons.check_circle_outline,
                ),
                label: const Text('Completar tarea'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}