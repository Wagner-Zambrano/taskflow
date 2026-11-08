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

// Modelo de datos Task
class Task {
  final String title;
  final String description;
  final String priority;
  final String status;

  const Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });
}

// Pantalla principal
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Backlog estático con cinco tareas reales de TaskFlow
  static const List<Task> tasks = [
    Task(
      title: 'Diseñar la pantalla principal',
      description:
          'Crear el panel de bienvenida con el nombre del estudiante, '
          'mensaje motivacional y diseño de TaskFlow.',
      priority: 'Alta',
      status: 'Completada',
    ),
    Task(
      title: 'Crear el modelo Task',
      description:
          'Definir la estructura de datos para almacenar título, '
          'descripción, prioridad y estado de cada tarea.',
      priority: 'Alta',
      status: 'En progreso',
    ),
    Task(
      title: 'Implementar el listado de tareas',
      description:
          'Mostrar las tareas del proyecto mediante ListView.builder '
          'para permitir el desplazamiento vertical.',
      priority: 'Alta',
      status: 'Pendiente',
    ),
    Task(
      title: 'Crear el componente TaskCard',
      description:
          'Diseñar una tarjeta reutilizable que presente la información '
          'de cada tarea de forma organizada.',
      priority: 'Media',
      status: 'Pendiente',
    ),
    Task(
      title: 'Implementar el detalle de tareas',
      description:
          'Agregar una acción visual para consultar los detalles '
          'de cada tarea seleccionada.',
      priority: 'Media',
      status: 'Pendiente',
    ),
  ];

  // Mostrar detalle de una tarea
  void showTaskDetail(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              const SizedBox(height: 16),
              Text(
                'Prioridad: ${task.priority}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Estado: ${task.status}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = tasks
        .where((task) => task.status == 'Completada')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TaskFlow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      // Pantalla desplazable
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.task_alt,
              size: 60,
              color: Colors.indigo,
            ),

            const SizedBox(height: 16),

            Text(
              '¡Hola, Wagner Zambrano!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 10),

            const Text(
              'Organiza tus tareas y alcanza tus objetivos.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            // Resumen del backlog
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.assignment,
                  color: Colors.indigo,
                  size: 35,
                ),
                title: const Text('Backlog de TaskFlow'),
                subtitle: Text(
                  '${tasks.length} tareas registradas · '
                  '$completedCount completada(s)',
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Mis tareas del proyecto',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // ListView.builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return TaskCard(
                  task: task,
                  onViewDetail: () {
                    showTaskDetail(context, task);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Tarjeta reutilizable TaskCard
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onViewDetail;

  const TaskCard({
    super.key,
    required this.task,
    required this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = task.status == 'Completada';

    final Color statusColor = isCompleted
        ? Colors.green
        : task.status == 'En progreso'
            ? Colors.orange
            : Colors.grey;

    final Color priorityColor = task.priority == 'Alta'
        ? Colors.red
        : task.priority == 'Media'
            ? Colors.orange
            : Colors.green;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 14),
      color: isCompleted ? Colors.green.shade50 : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y estado visual
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: statusColor,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Descripción
            Text(
              task.description,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 14),

            // Prioridad
            Row(
              children: [
                const Icon(
                  Icons.flag,
                  size: 18,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 6),
                const Text('Prioridad: '),
                Text(
                  task.priority,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Estado
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: statusColor,
                ),
                const SizedBox(width: 6),
                const Text('Estado: '),
                Text(
                  task.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Acción visual de detalle
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onViewDetail,
                icon: const Icon(Icons.visibility),
                label: const Text('Ver detalle'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}