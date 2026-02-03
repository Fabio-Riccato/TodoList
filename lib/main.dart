// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';
import 'screens_task.dart';
import 'screen_stats.dart';

void main() {
  runApp(
    // Colleghiamo il provider a tutta l'app
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MaterialApp(
        home: SchermataPrincipale(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class SchermataPrincipale extends StatelessWidget {
  const SchermataPrincipale({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController gestisce le 2 schede (Task e Stats)
    return DefaultTabController(
      length: 2,
      child:// Parte modificata di main.dart
      Scaffold(
          appBar: AppBar(
            title: const Text("La Mia Todo List"),
            backgroundColor: Colors.blue,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list), text: "Le tue Liste"),
                Tab(icon: Icon(Icons.pie_chart), text: "Statistiche"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              PaginaCompiti(),
              PaginaStatistiche(),
            ],
          ),
          // Questo bottone appare solo per aggiungere TASK
          floatingActionButton: Builder(
              builder: (context) {
                return FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    // Importa la funzione o definiscila qui
                    // Per semplicità, richiamiamo la logica qui:
                    final provider = Provider.of<TodoProvider>(context, listen: false);
                    final controller = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Nuovo Task"),
                          content: TextField(controller: controller, autofocus: true),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  if(controller.text.isNotEmpty) {
                                    provider.aggiungiTask(controller.text);
                                    Navigator.pop(ctx);
                                  }
                                },
                                child: const Text("Salva")
                            )
                          ],
                        )
                    );
                  },
                );
              }
          ),
        ),
    );
  }
}
