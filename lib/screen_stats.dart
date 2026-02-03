// screens_stats.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class PaginaStatistiche extends StatelessWidget {
  const PaginaStatistiche({super.key});

  @override
  Widget build(BuildContext context) {
    // Usiamo watch per ridisegnare la pagina se i dati cambiano
    final provider = context.watch<TodoProvider>();

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: provider.liste.length,
      itemBuilder: (context, index) {
        final lista = provider.liste[index];

        // CALCOLI SEMPLICI
        int totale = lista.tasks.length;
        int svolti = lista.tasks.where((t) => t.isFatto).length;
        int daSvolgere = totale - svolti;
        double percentuale = totale == 0 ? 0 : (svolti / totale);

        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome Lista
                Text(
                  lista.nomeLista,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const Divider(),
                // Dati
                Text("Totale inseriti: $totale"),
                Text("Da svolgere: $daSvolgere", style: const TextStyle(color: Colors.red)),
                Text("Svolti: $svolti", style: const TextStyle(color: Colors.green)),
                const SizedBox(height: 10),

                // Barra percentuale
                Text("Efficienza: ${(percentuale * 100).toStringAsFixed(1)}%"),
                LinearProgressIndicator(
                  value: percentuale,
                  backgroundColor: Colors.grey[300],
                  color: Colors.green,
                  minHeight: 8,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}