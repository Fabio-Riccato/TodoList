// screens/list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Column(
            children: [
              // SELETTORE LISTA
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue.shade50,
                child: Row(
                  children: [
                    const Text("Lista Attiva: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<int>(
                        value: provider.indiceListaAttiva,
                        isExpanded: true,
                        items: List.generate(provider.liste.length, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(provider.liste[index].nomeLista),
                          );
                        }),
                        onChanged: (int? newIndex) {
                          if (newIndex != null) provider.cambiaLista(newIndex);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_box, color: Colors.blue),
                      tooltip: "Nuova Lista",
                      onPressed: () => _showAddListDialog(context, provider),
                    )
                  ],
                ),
              ),

              // LISTA DEI TASK
              Expanded(
                child: provider.listaCorrente.tasks.isEmpty
                    ? const Center(child: Text("Nessun task in questa lista."))
                    : ListView.builder(
                  itemCount: provider.listaCorrente.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.listaCorrente.tasks[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.isFatto,
                          onChanged: (_) => provider.togliMettiSpunta(index),
                        ),
                        title: Text(
                          task.titolo,
                          style: TextStyle(
                            decoration: task.isFatto
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isFatto ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => provider.eliminaTask(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddTaskDialog(context, provider),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  // Dialog per aggiungere un TASK
  void _showAddTaskDialog(BuildContext context, TodoProvider provider) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nuovo Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Cosa devi fare?"),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annulla")),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                provider.aggiungiTask(controller.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text("Aggiungi"),
          ),
        ],
      ),
    );
  }

  // Dialog per creare una nuova LISTA
  void _showAddListDialog(BuildContext context, TodoProvider provider) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nuova Lista"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Nome della lista (es. Spesa)"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annulla")),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                provider.creaNuovaLista(controller.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text("Crea"),
          ),
        ],
      ),
    );
  }
}