// screens_task.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class PaginaCompiti extends StatelessWidget {
  const PaginaCompiti({super.key});

  @override
  Widget build(BuildContext context) {
    // Usiamo Consumer per ascoltare i cambiamenti dei dati
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // --- ZONA SELEZIONE LISTA ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.blue[50],
              child: Row(
                children: [
                  const Text("Lista attuale: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  // Dropdown per cambiare lista
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
                      onChanged: (nuovoIndice) {
                        if (nuovoIndice != null) provider.cambiaLista(nuovoIndice);
                      },
                    ),
                  ),
                  // Bottone per aggiungere NUOVA LISTA
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.blue),
                    onPressed: () => _dialogNuovaLista(context, provider),
                  )
                ],
              ),
            ),

            // --- LISTA DEI TASK ---
            Expanded(
              child: ListView.builder(
                itemCount: provider.listaCorrente.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.listaCorrente.tasks[index];
                  return CheckboxListTile(
                    title: Text(
                      task.titolo,
                      style: TextStyle(
                        // Se è fatto, barriamo il testo
                        decoration: task.isFatto ? TextDecoration.lineThrough : null,
                        color: task.isFatto ? Colors.grey : Colors.black,
                      ),
                    ),
                    value: task.isFatto,
                    onChanged: (val) => provider.togliMettiSpunta(index),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.eliminaTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Metodo helper per mostrare il popup (Dialog)
  void _dialogNuovaLista(BuildContext context, TodoProvider provider) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Crea Nuova Lista"),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: "Nome lista (es. Viaggio)")),
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
          )
        ],
      ),
    );
  }
}

// Aggiungiamo un FloatingActionButton alla pagina principale per i task?
// Per semplicità, mettiamo un bottone flottante separato dentro la pagina compiti
// Nota: In Flutter, il FAB di solito sta nello Scaffold, ma possiamo usare un trucco o un bottone nella UI.
// Per questo esempio, aggiungeremo un bottone "Aggiungi Task" in fondo alla lista o useremo un FloatingActionButton nello Scaffold.
// MODIFICA: Per semplicità estrema, aggiungo un tasto "+ Aggiungi Elemento" persistente in basso.

// Aggiorna lo Scaffold in main.dart per avere il floatingActionButton che chiama questo metodo:
void mostraDialogAggiungiTask(BuildContext context) {
  final provider = Provider.of<TodoProvider>(context, listen: false);
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Aggiungi a ${provider.listaCorrente.nomeLista}"),
      content: TextField(controller: controller, autofocus: true),
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
        )
      ],
    ),
  );
}