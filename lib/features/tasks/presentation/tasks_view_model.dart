import 'package:flutter/foundation.dart';

import '../data/task_repository.dart';
import '../domain/task.dart';

class TasksViewModel extends ChangeNotifier {
  TasksViewModel(this._repository);

  final TaskRepository _repository;

  List<Task> _tasks = [];

  bool isLoading = false;
  String? errorMessage;

  // Lista de tareas disponibles.
  List<Task> get tasks => List.unmodifiable(_tasks);

  // Comprueba si la respuesta fue válida, pero no contiene tareas.
  bool get isEmpty => !isLoading && errorMessage == null && _tasks.isEmpty;

  // Carga las tareas desde el repositorio.
  Future<void> loadTasks() async {
    // Evita realizar varias peticiones al mismo tiempo.
    if (isLoading) return;

    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      _tasks = await _repository.getTasks();
    } catch (error) {
      _tasks = [];

      errorMessage = 'No se pudieron cargar las tareas.';

      debugPrint('Error al cargar tareas: $error');
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  // Busca una tarea por su identificador.
  Task? findTask(int? id) {
    if (id == null) return null;

    for (final task in _tasks) {
      if (task.id == id) {
        return task;
      }
    }

    return null;
  }

  // Cambia el estado de una tarea.
  void toggleCompleted(int id) {
    final current = findTask(id);

    if (current == null) return;

    final updated = current.copyWith(isCompleted: !current.isCompleted);

    _repository.save(updated);

    _tasks = [
      for (final task in _tasks)
        if (task.id == id) updated else task,
    ];

    notifyListeners();
  }
}
