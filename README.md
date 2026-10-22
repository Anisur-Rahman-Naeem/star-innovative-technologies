# Deen-Step Flutter Application

A high-performance, spiritually-focused Flutter application built with **Clean Architecture** and **BLoC** state management. This project demonstrates a production-grade approach to feature modularity, real-time location services, and responsive UI design.

---

## 🚀 Getting Started

### Prerequisites

*   **Flutter SDK**: `^3.13.2`
*   **Dart SDK**: `^3.1.0`
*   **Android Studio / VS Code** with Flutter & Dart plugins
*   **CocoaPods** (for iOS builds)

### How to Run

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Anisur-Rahman-Naeem/star-innovative-technologies.git
    cd interview_task
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the application**:
    ```bash
    # For Debug mode
    flutter run

    # For Release APK
    flutter build apk --release
    ```

---

## 📂 Folder Structure

The project follows **Clean Architecture** principles to ensure separation of concerns, testability, and scalability.

```text
lib/
├── core/               # App-wide constants, themes, and shared services (Location, API Client)
├── features/           # Modularized feature folders
│   ├── auth/           # Authentication module (Managed on a separate branch)
│   │   ├── data/       # Models, Repositories, Data Sources
│   │   ├── domain/     # Entities, Use Cases (Business Logic)
│   │   └── presentation/# BLoCs, Pages, Widgets
│   └── home/           # Dashboard and Location management
│       ├── data/       
│       ├── domain/     
│       └── presentation/
└── main.dart           # Application entry point & Dependency Injection
```

---

## 🧠 State Management

This project utilizes **BLoC (Business Logic Component)** to maintain a strict separation between UI and logic.

*   **Logic Isolation**: All business logic resides in `Bloc` classes.
*   **Predictable States**: Uses `equatable` for efficient state comparison and UI rebuilding.
*   **Event-Driven**: Actions like `GetLocationRequested` or `GetDashboardDataRequested` trigger state changes asynchronously, ensuring a lag-free UI.

---

## 🔄 Switching Branches (Feature Modules)

The repository is structured to handle modular development through Git branching:

*   **Main Branch**: Contains the core application logic and the `home` feature.
*   **Auth Branch**: Contains the `auth` module specifically.

**Switching Contexts**:
```bash
# To work on the core dashboard:
git checkout main

# To work on authentication/onboarding:
git checkout feature/auth
```

---

## 🛠 Step-by-Step Guide: Adding a New Feature

To add a new feature (e.g., `community`), follow these standardized steps:

### 1. Create the Directory Structure
Create a new folder under `lib/features/community/` with subfolders for `data`, `domain`, and `presentation`.

### 2. Define the Domain Layer
*   Create an **Entity** (the core data object).
*   Define a **Repository Interface** (contract for data fetching).

### 3. Implement the Data Layer
*   Create a **Model** (extends the entity with JSON serialization).
*   Implement the **Repository** that fetches data from an API (using `Dio`) or local database.

### 4. Logic & State (BLoC)
Create a `CommunityBloc`, `CommunityEvent`, and `CommunityState`:
*   **Event**: `FetchPosts`
*   **State**: `CommunityLoading`, `CommunityLoaded`, `CommunityError`

### 5. Presentation Layer
*   Build the UI using `BlocBuilder` or `BlocListener` to react to state changes.
*   Inject the BLoC at the top of the feature tree using `BlocProvider`.

### 6. Dependency Injection
Register the new repository and BLoC in the global provider (located in `main.dart` or a specialized injection container).

---

## 🎨 UI Design Standards

*   **Theme**: Dark-mode centric (`0xFF0D0D0D`) with neon primary accents (`0xFFB4FF39`).
*   **Typography**: Uses `RichText` for precise keyword highlighting.
*   **Components**: Custom high-fidelity modals with `28.0` border radius and `0xFF121413` surface colors.
