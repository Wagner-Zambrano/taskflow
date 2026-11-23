# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Alcance de TaskFlow

### Problema
Los estudiantes necesitan organizar sus actividades académicas y conocer cuáles están pendientes y cuáles ya terminaron.

### Usuario objetivo
Estudiantes que necesitan organizar sus tareas y planificar sus actividades académicas.

### Historias de usuario y criterios de aceptación

1. Como estudiante, quiero visualizar mis tareas para saber qué actividades debo realizar.
   - Criterio: la lista muestra el título, prioridad y estado de cada tarea.

2. Como estudiante, quiero consultar el detalle de una tarea para conocer su descripción.
   - Criterio: al tocar una tarjeta se abre el detalle de la tarea seleccionada.

3. Como estudiante, quiero crear tareas para registrar nuevas actividades.
   - Criterio: el formulario permitirá guardar una tarea con título y descripción.

4. Como estudiante, quiero editar mis tareas para corregir su información.
   - Criterio: los cambios guardados se reflejarán en la lista y en el detalle.

5. Como estudiante, quiero eliminar tareas para mantener organizado mi listado.
   - Criterio: después de confirmar la eliminación, la tarea desaparecerá de la lista.

### Modelo de datos

Task:
- id: identificador único (entero).
- title: título (texto).
- description: descripción (texto).
- priority: prioridad (Alta, Media o Baja).
- isCompleted: estado (verdadero o falso).
- userId: identificador del usuario (entero).

### Pantallas previstas

- Lista: muestra las tareas registradas.
- Detalle: presenta toda la información de una tarea.
- Formulario: permitirá crear y editar tareas.

### Requisitos no funcionales

- La aplicación debe mostrar mensajes comprensibles.
- La navegación debe permitir regresar al listado.
- Un identificador inexistente debe mostrar un mensaje entendible.

### Contrato de API previsto

- GET /tasks: listar tareas.
- GET /tasks/:id: consultar una tarea.
- POST /tasks: crear una tarea.
- PATCH /tasks/:id: actualizar una tarea.
- DELETE /tasks/:id: eliminar una tarea.

La API todavía no está conectada. Estas rutas representan las operaciones que se necesitarán en futuras sesiones.
