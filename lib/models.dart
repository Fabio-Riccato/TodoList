// models.dart

class Task {
  String titolo;
  bool isFatto;

  Task({required this.titolo, this.isFatto = false});
}

class ListaDiTask {
  String nomeLista; // Es: "Spesa", "Scuola"
  List<Task> tasks;

  ListaDiTask({required this.nomeLista, List<Task>? tasks})
      : tasks = tasks ?? [];
}