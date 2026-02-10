# To-Do List

Un'applicazione To-Do List semplice realizzata in Flutter, progettata per gestire più liste di attività e monitorare la produttività tramite statistiche.

**Nota Importante:** Questa versione dell'applicazione utilizza la gestione dello stato in memoria (RAM). **I dati non vengono salvati in modo permanente**: chiudendo e riaprendo l'app, le liste e i task torneranno allo stato iniziale.

## Funzionalità Principali

* **Multi-Lista:** Crea liste personalizzate per diverse categorie (es. Spesa, Lavoro, Studio).
* **Gestione Task:** Aggiungi nuovi compiti, spuntali come completati o eliminali.
* **Statistiche Dinamiche:** Una scheda dedicata mostra per ogni lista:
    * Totale task inseriti.
    * Task completati vs Task da svolgere.
    * Barra di efficienza.
* **Interfaccia a Schede:** Navigazione tra "Task" e "Statistiche" tramite TabBar.
* **UI Pulita:** Utilizzo di gap per la spaziatura.

## Tecnologie e Pacchetti Utilizzati

* **Flutter & Dart**: Framework UI e linguaggio.
* **Provider**: Per la gestione dello stato (State Management) e e la consivisione dei dati tra le pagine.
* **Gap**: Per la gestione semplificata degli spazi (margin/padding) nel layout.

## Struttura del Progetto


* main: Punto di iniziale dell'app, configurazione del tema e struttura della TabBar.
* todo_provider: Contiene i modelli dei dati (Task, ListaDiTask). Gestisce l'aggiunta e la rimozione degli elementi.
* screens_task: La schermata principale per selezionare le liste, aggiungere e gestire i task.
* screens_stats: La schermata che calcola e visualizza i grafici di efficienza per ogni lista.



## Sviluppi Futuri

* Integrazione di sqflite per il salvataggio persistente dei dati.
* Possibilità di modificare il nome delle liste.
