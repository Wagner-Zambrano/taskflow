import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Datos temporales de la nueva tarea.
class TaskDraft {
  const TaskDraft(this.title, this.description, this.priority, {this.date});

  final String title;
  final String description;
  final String priority;
  final DateTime? date;
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _description = TextEditingController();

  String _priority = 'Media';

  // Fecha opcional del trabajo autónomo.
  DateTime? _selectedDate;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  // Abre el calendario para seleccionar una fecha.
  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      helpText: 'Selecciona la fecha de la tarea',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (selected != null) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }

  // Elimina la fecha seleccionada.
  void _clearDate() {
    setState(() {
      _selectedDate = null;
    });
  }

  // Valida el formulario y devuelve el borrador.
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final draft = TaskDraft(
      _title.text.trim(),
      _description.text.trim(),
      _priority,
      date: _selectedDate,
    );

    context.pop(draft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Campo del título.
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Escribe el título de la tarea',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                final title = value?.trim() ?? '';

                if (title.isEmpty) {
                  return 'Escribe un título.';
                }

                if (title.length < 3) {
                  return 'Usa al menos 3 caracteres.';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            // Campo de descripción.
            TextFormField(
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Describe la tarea',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            // Selector de prioridad.
            DropdownButtonFormField<String>(
              initialValue: _priority,
              decoration: const InputDecoration(
                labelText: 'Prioridad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flag),
              ),
              items: ['Alta', 'Media', 'Baja']
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _priority = value ?? 'Media';
                });
              },
            ),

            const SizedBox(height: 20),

            // Fecha opcional.
            const Text(
              'Fecha de la tarea (opcional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _selectedDate == null
                    ? 'Seleccionar fecha'
                    : MaterialLocalizations.of(context)
                          .formatMediumDate(_selectedDate!),
              ),
            ),

            if (_selectedDate != null)
              TextButton.icon(
                onPressed: _clearDate,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Quitar fecha'),
              ),

            const SizedBox(height: 28),

            // Botón para validar y devolver los datos.
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
