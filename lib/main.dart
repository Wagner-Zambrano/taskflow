import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'task.dart';

void main() {
  runApp(const TaskFlowApp());
}

// LISTA ESTÁTICA DE CINCO TAREAS REALES DE TASKFLOW
const List<Task> demoTasks = [
  Task(
    id: 1,
    title: 'Diseñar la pantalla principal',
    description:
        'Crear el panel de bienvenida con el nombre del estudiante, '
        'mensaje motivacional y diseño de TaskFlow.',
    priority: 'Alta',
    isCompleted: true,
    userId: 1,
  ),
  Task(
    id: 2,
    title: 'Crear el modelo Task',
    description:
        'Definir la estructura de datos para almacenar el identificador, '
        'título, descripción, prioridad, estado y usuario de cada tarea.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 3,
    title: 'Implementar el listado de tareas',
    description:
        'Mostrar las tareas del proyecto mediante ListView.builder '
        'para permitir el desplazamiento vertical.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 4,
    title: 'Crear el componente TaskCard',
    description:
        'Diseñar una tarjeta reutilizable para presentar la información '
        'de cada tarea de forma organizada.',
    priority: 'Media',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 5,
    title: 'Implementar la navegación',
    description:
        'Configurar GoRouter para abrir los detalles de cada tarea '
        'y regresar al listado.',
    priority: 'Media',
    isCompleted: false,
    userId: 1,
  ),
];

// BUSCAR UNA TAREA POR SU IDENTIFICADOR
Task? findTask(int? id) {
  for (final task in demoTasks) {
    if (task.id == id) {
      return task;
    }
  }
  return null;
}

// CONFIGURACIÓN DE RUTAS CON GO ROUTER
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TaskListScreen()),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.tryParse(state.pathParameters['id'] ?? '');

        return TaskDetailScreen(taskId: taskId);
      },
    ),
  ],
);

// APLICACIÓN PRINCIPAL
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

// PANTALLA DEL LISTADO DE TAREAS
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedCount = demoTasks.where((task) => task.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TaskFlow - Mis tareas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ENCABEZADO
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.task_alt, size: 55, color: Colors.indigo),
                const SizedBox(height: 12),
                Text(
                  '¡Hola, Wagner Zambrano!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Organiza tus tareas y alcanza tus objetivos.',
                  style: TextStyle(fontSize: 15, color: Colors.indigo),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mis tareas: ${demoTasks.length} '
                  '| Completadas: $completedCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // LISTA DESPLAZABLE
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: demoTasks.length,
              itemBuilder: (context, index) {
                final task = demoTasks[index];

                return TaskCard(
                  task: task,
                  onTap: () {
                    context.push('/task/${task.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// TARJETA REUTILIZABLE
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.indigo,
          size: 30,
        ),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('${task.priority} · ${task.description}'),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.indigo),
      ),
    );
  }
}

// PANTALLA DE DETALLE DE TAREA
class TaskDetailScreen extends StatelessWidget {
  final int? taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    // BUSCAR LA TAREA MEDIANTE SU IDENTIFICADOR
    final task = findTask(taskId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de tarea'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: task == null
            ? const Center(
                child: Text(
                  'No se encontró esta tarea.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ICONO
                  Icon(
                    task.isCompleted ? Icons.check_circle : Icons.assignment,
                    size: 65,
                    color: task.isCompleted ? Colors.green : Colors.indigo,
                  ),

                  const SizedBox(height: 24),

                  // TÍTULO
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 20),

                  // DESCRIPCIÓN
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(task.description, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 24),

                  // IDENTIFICADOR
                  Text(
                    'Identificador: ${task.id}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  // PRIORIDAD
                  Chip(
                    avatar: const Icon(Icons.flag, color: Colors.indigo),
                    label: Text('Prioridad: ${task.priority}'),
                  ),

                  const SizedBox(height: 12),

                  // ESTADO
                  Row(
                    children: [
                      Icon(
                        task.isCompleted
                            ? Icons.check_circle
                            : Icons.pending_actions,
                        color: task.isCompleted ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        task.isCompleted
                            ? 'Estado: Completada'
                            : 'Estado: Pendiente',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: task.isCompleted
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // USUARIO
                  Text(
                    'Usuario: ${task.userId}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const Spacer(),

                  // REGRESAR AL LISTADO
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver al listado'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
