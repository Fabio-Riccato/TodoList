// todo_provider.dart
import 'package:flutter/material.dart';
import 'models.dart';

class TodoProvider extends ChangeNotifier {
  // Elenco di tutte le liste create dall'utente
  List<ListaDiTask> liste = [
    ListaDiTask(nomeLista: "Generale"), // Lista di default
  ];

  // Indice per sapere quale lista stiamo guardando (0 = la prima, 1 = la seconda...)
  int indiceListaAttiva = 0;

  // Ritorna la lista che l'utente sta guardando ora
  ListaDiTask get listaCorrente => liste[indiceListaAttiva];

  // Cambia la lista attiva
  void cambiaLista(int nuovoIndice) {
    indiceListaAttiva = nuovoIndice;
    notifyListeners(); // Aggiorna la grafica
  }

  // Crea una nuova lista (es: "Lavoro")
  void creaNuovaLista(String nome) {
    liste.add(ListaDiTask(nomeLista: nome));
    indiceListaAttiva = liste.length - 1; // Sposta subito la vista sulla nuova lista
    notifyListeners();
  }

  // Aggiunge un task alla lista che stiamo guardando
  void aggiungiTask(String titoloTask) {
    listaCorrente.tasks.add(Task(titolo: titoloTask));
    notifyListeners();
  }

  // Spunta (o toglie la spunta) a un task
  void togliMettiSpunta(int indiceTask) {
    var task = listaCorrente.tasks[indiceTask];
    task.isFatto = !task.isFatto;
    notifyListeners();
  }

  // Cancella un task
  void eliminaTask(int indiceTask) {
    listaCorrente.tasks.removeAt(indiceTask);
    notifyListeners();
  }

}