import 'package:flutter/material.dart';
import 'package:my_portfolio/models/hobby.dart';
import 'package:my_portfolio/widgets/add_hobby_dialog.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/hobby_card.dart';
import 'package:my_portfolio/widgets/hobbies_counter.dart';

/// Pantalla CRUD: lista dinámica de hobbies, con alta (Dialog) y baja.
/// Es StatefulWidget porque la lista cambia con las acciones del usuario.
class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  // Espacio inferior para que el botón flotante no tape el último hobby.
  static const double _fabSpace = 88;

  final List<Hobby> _hobbies = [];

  Future<void> _openAddDialog() async {
    // showDialog devuelve lo que el diálogo pase en Navigator.pop (o null).
    final Hobby? newHobby = await showDialog<Hobby>(
      context: context,
      builder: (context) => const AddHobbyDialog(),
    );
    if (newHobby == null || !mounted) return;
    setState(() => _hobbies.add(newHobby));
  }

  void _deleteHobby(Hobby hobby) {
    setState(() => _hobbies.remove(hobby));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis hobbies')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        tooltip: 'Añadir hobby',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: HobbiesCounter(total: _hobbies.length),
          ),
          Expanded(
            // Renderizado condicional: mensaje si la lista está vacía.
            child: _hobbies.isEmpty
                ? const Center(child: Text('Aún no hay hobbies. ¡Añade uno!'))
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, _fabSpace),
                    children: _hobbies
                        .map(
                          (hobby) => HobbyCard(
                            hobby: hobby,
                            onDelete: () => _deleteHobby(hobby),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
