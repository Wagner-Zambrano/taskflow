import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Diseñar la pantalla principal',
      description: 'Crear el panel de bienvenida de TaskFlow con el nombre del estudiante y un mensaje motivacional.',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Crear el modelo Task',
      description: 'Definir los atributos de cada tarea: identificador, título, descripción, prioridad, estado y usuario.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Implementar el listado',
      description:
          'Mostrar las tareas registradas utilizando ListView.builder.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Crear TaskCard',
      description: 'Diseñar una tarjeta reutilizable para mostrar la información de cada tarea.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Implementar la navegación',
      description: 'Permitir navegar desde el listado hasta la pantalla de detalle de cada tarea.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);

    if (index == -1) return;

    _tasks[index] = task;
  }
}
