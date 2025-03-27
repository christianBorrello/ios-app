# 📱 Habit Journey

App iOS per il tracciamento delle abitudini e la gestione dei task personali, con elementi di gamification, ricorrenze settimanali, e una UI interattiva sviluppata in SwiftUI.

---

## 🚀 Roadmap di sviluppo

### ✅ Fase 1: Fondamenta dell'app
- [x] Creazione dell'app con SwiftUI
- [x] Implementazione architettura MVVM
- [x] Separazione Views / ViewModels / Models
- [x] Sistema di temi (chiaro/scuro/auto)
- [x] Navigazione tramite TabView

---

### ✅ Fase 2: Task
- [x] Visualizzazione dei task programmati per oggi
- [x] Form per la creazione di un nuovo task
- [x] Selezione emoji, titolo, descrizione e scadenza
- [x] Preview dei task
- [x] Suddivisione in file separati (View, ViewModel, Model)
- [x] Aggiungere il popup di conferma eliminazione task
- [x] Aggiungere l'orario oltre la data
- [x] Aggiungere i pulsanti "salva" e "annulla" nella view di modifica del task

---

### ✅ Fase 3: Habits
- [x] Visualizzazione delle abitudini attive
- [x] Form di aggiunta nuova abitudine
- [x] Ricorrenza settimanale personalizzabile (giorni selezionabili)
- [x] Visualizzazione dei pallini settimanali
- [ ] Aggiungere il meccanismo di checking in base al giorno corrente
- [ ] Tracciamento dei completamenti e streak
- [ ] Ideare un sistema conforme per quando si salta un giorno di streak nel completamento della barra verde
- [x] Vista dettaglio dell’abitudine con possibilità di modifica
- [x] Aggiungere l'orario oltre la data (opzionale)
- [x] Aggiungere i pulsanti "salva" e "annulla" nella view di modifica dell'abitudine

---

### ✅ Fase 4: Home
- [x] Header con benvenuto e data
- [x] Sezione Task di oggi
- [x] Sezione Abitudini di oggi
- [x] Riepilogo attività di domani
- [x] Bottone per aprire calendario
- [ ] Dare la possibilità di checkare l'attività solo dalla schermata Home e in riferimento al giorno e all'orario di riferimento

---

### ✅ Fase 5: Calendario
- [x] Visualizzazione attività per la settimana corrente
- [x] Navigazione tra settimane (prec/succ)
- [x] Visualizzazione task e abitudini per giorno
- [x] Calendario in file separato
- [ ] Rendere funzionale il pulsante per checkare l'attività (task o abitudine)
- [x] Dare all'utente la possibilità di aprire il singolo Task o Attività a partire dalla CalendarView
- [x] Invece di oggi al centro in basso dare un feedback sulla settimana corrente in modo che l'utente, spostandosi tra le settimane capisca in quale settimana si trova

---

## 🧱 Fase 6: Persistenza dati (in corso)
- [ ] Salvataggio di task e abitudini su disco (Codable + FileManager)
- [ ] Persistenza delle abitudini e completamenti
- [ ] Caricamento all'avvio
- [ ] Eliminazione/modifica dei dati

---

## 💡 Fase 7: Miglioramenti futuri
- [ ] Sezione “Progressi” con grafici (Swift Charts)
- [ ] Notifiche giornaliere di reminder (Local Notifications)
- [ ] Sincronizzazione con calendario iOS (facoltativa)
- [ ] Aggiunta animazioni per gamification
- [ ] Possibilità di condividere obiettivi con amici

---

## 🎯 Obiettivo finale
Un'app semplice, motivante e piacevole da usare, con:
- Tracciamento visivo delle abitudini
- Gestione task efficace e personalizzabile
- Interfaccia curata
- Preparazione alla pubblicazione su App Store

---

## 👨‍💻 Tecnologie utilizzate
- Swift 5
- SwiftUI
- MVVM
- Xcode Preview
- DateFormatter, Calendar API
