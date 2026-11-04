import 'package:flutter/material.dart';
import 'package:my_portfolio/models/hobby_category.dart';
import 'package:my_portfolio/models/hobby.dart';

/// Modal (AlertDialog) con el formulario para añadir un hobby.
/// Es un StatefulWidget porque guarda la categoría elegida y los controladores.
/// Al aceptar devuelve el Hobby con Navigator.pop; al cancelar, null.
class AddHobbyDialog extends StatefulWidget {
  const AddHobbyDialog({super.key});

  @override
  State<AddHobbyDialog> createState() => _AddHobbyDialogState();
}

class _AddHobbyDialogState extends State<AddHobbyDialog> {
  static const int _maxDescriptionLength = 80; // descripción breve

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  HobbyCategory _category = HobbyCategory.values.first;

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget.
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  void _submit() {
    // validate() ejecuta los validator de todos los campos del Form.
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Hobby(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _category,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo hobby'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _validateRequired,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLength: _maxDescriptionLength,
                maxLines: 2,
                validator: _validateRequired,
              ),
              DropdownButtonFormField<HobbyCategory>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: [
                  for (final category in HobbyCategory.values)
                    DropdownMenuItem(
                      value: category,
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(category.icon, size: 20),
                          Text(category.label),
                        ],
                      ),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Añadir')),
      ],
    );
  }
}
