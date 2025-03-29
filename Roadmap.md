# Roadmap di Apprendimento - iOS Habit Tracker App

Questa roadmap ti guiderà attraverso l'apprendimento delle tecnologie e dei concetti fondamentali utilizzati nello sviluppo dell'app Habit Tracker, permettendoti di acquisire autonomia completa nel suo sviluppo e mantenimento.

---

## 1. Fondamenti di Swift e SwiftUI

### Swift
- Sintassi di base, tipi di dato, funzioni, closure
- Struct vs Class
- Protocols e Extensions
- Optionals e gestione sicura dei dati

### SwiftUI
- `@State`, `@Binding`, `@ObservedObject`, `@StateObject`, `@Environment`
- `View`, `NavigationView`, `Form`, `List`, `ScrollView`
- Modificatori (`.padding`, `.background`, `.cornerRadius`, etc.)
- Sheet, Alert, NavigationLink
- Custom Components

---

## 2. Architettura dell'app

### MVVM (Model-View-ViewModel)
- Separazione delle responsabilità
- Comunicazione tra View e ViewModel
- Uso di ObservableObject e @Published
- Gestione del ciclo di vita della ViewModel

---

## 3. Persistenza dati

### AppStorage e UserDefaults
- Conservare preferenze utente (es. tema selezionato)

### Codifica/Decodifica JSON
- Codable
- Archiviazione temporanea dei dati (mock data)

*(In futuro potresti espandere con CoreData o SQLite per la persistenza a lungo termine)*

---

## 4. Navigazione e interazione

- `NavigationStack` e `NavigationLink`
- Gestione modali con `.sheet`
- Gestione toolbar e pulsanti di navigazione

---

## 5. UI/UX Design

- Progettazione di interfacce reattive
- Animazioni (`withAnimation`, `.transition`, `GeometryReader`)
- Uso di colori personalizzati (AppColors.swift)
- Adattamento per light/dark mode

---

## 6. Componenti Riutilizzabili

- Creazione di card custom (TaskCardView, HabitCardView)
- Separazione della logica in componenti riutilizzabili
- Preview con `#Preview`

---

## 7. Gestione della Data e del Calendario

- `Date`, `Calendar`, `DateFormatter`
- Calcolo di settimane, giorni correnti, orari
- Weekday enum personalizzato

---

## 8. Debug e miglioramento performance

- Uso del canvas e preview per sviluppo rapido
- Debug della UI con Xcode
- Evitare errori come: "Unable to type-check this expression..."

---

## 9. Estensioni e Helpers

- Estensioni di `View`, `Date`, `Color`
- Utility per migliorare leggibilità e manutenibilità

---

## 10. Espansioni Future

- Persistenza con Core Data o CloudKit
- Notifiche locali per task e abitudini
- Sincronizzazione multi-dispositivo
- Accessibilità e supporto per lingue multiple

---

> Questa roadmap può essere seguita progressivamente oppure approfondita in base alle tue priorità o alle funzionalità da implementare.