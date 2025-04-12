# 🖋 **Flutter Task & Note Manager**

### **Une application Flutter complète pour gérer les tâches et les notes avec des fonctionnalités avancées comme les rappels programmés et les notifications personnalisées.**

---

## 🌟 **Fonctionnalités**

- **Gestion des tâches :**

    - Ajouter, modifier et supprimer des tâches.
    - Programmer des rappels pour les tâches avec notifications.

- **Gestion des notes :**

    - Ajouter et organiser vos notes dans une interface intuitive.
    - Recherche intégrée pour filtrer les notes rapidement.
    - Affichage des notes dans une vue grille (GridView) avec des cartes colorées de manière aléatoire.

- **Notifications programmées :**

    - Rappels précis utilisant les fuseaux horaires locaux détectés automatiquement.
    - Notifications personnalisées avec des images associées.

- **Base de données locale :**

    - Stockage des données (tâches et notes) en utilisant `Sqflite` pour une gestion rapide et persistante.

- **Interface moderne et responsive :**

    - Conçue pour s'adapter aux différentes tailles d'écran avec `flutter_screenutil`.

---

## 🚀 **Installation**

### **Pré-requis**

- [Flutter](https://flutter.dev/docs/get-started/install) 3.0 ou supérieur.
- Environnement de développement configuré (Android Studio, VS Code, etc.).
- Un émulateur ou appareil physique pour tester l'application.

### **Étapes**

1. Clonez ce dépôt :

   ```bash
   git clone https://github.com/votre-utilisateur/flutter-task-note-manager.git
   cd flutter-task-note-manager
   ```

2. Installez les dépendances :

   ```bash
   flutter pub get
   ```

3. Lancez l'application :

   ```bash
   flutter run
   ```

---

## 💂 **Architecture**

L'application est organisée comme suit :

```
lib/
├── models/              # Modèles de données (Todo, Note)
├── services/            # Services (Base de données, Notifications)
├── screens/             # Interfaces utilisateur (Tâches, Notes, Éditeur de Notes)
├── widgets/             # Composants réutilisables (Ex. : barre de recherche)
└── main.dart            # Point d'entrée de l'application
```

---

## 🛠️ **Technologies utilisées**

- **Flutter** : Framework principal.
- **Dart** : Langage de programmation.
- **Sqflite** : Base de données locale.
- **Flutter Local Notifications** : Gestion des notifications.
- **Timezone** : Gestion des fuseaux horaires.
- **Flutter Native Timezone** : Détection du fuseau horaire du téléphone.

---

## 🖼️ **Captures d'écran**

| Vue des tâches | Vue des notes | Notification |
| -------------- | ------------- | ------------ |
|                |               |              |

*(Ajoutez des captures d'écran de votre application ici.)*

---

## ✨ **Fonctionnalités futures**

- Synchronisation cloud pour partager les tâches et notes entre appareils.
- Gestion des catégories et étiquettes pour organiser les notes et tâches.
- Thème clair/sombre.

---

## 🤝 **Contributions**

Les contributions sont les bienvenues ! Si vous souhaitez améliorer l'application ou ajouter des fonctionnalités, suivez ces étapes :

1. Fork ce dépôt.
2. Créez une branche pour vos modifications :
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Commitez vos modifications :
   ```bash
   git commit -m 'Ajout d’une fonctionnalité incroyable'
   ```
4. Poussez vos modifications :
   ```bash
   git push origin feature/amazing-feature
   ```
5. Ouvrez une Pull Request.

---

## 📄 **Licence**

Ce projet est sous licence MIT. Consultez le fichier [LICENSE](LICENSE) pour plus d’informations.

---

## ❤️ **Remerciements**

- Merci à la communauté Flutter pour sa documentation et ses exemples riches.
- Icônes et assets : [Flaticon](https://www.flaticon.com/), [Undraw](https://undraw.co/).

---

### 🛠️ **Développeur**

[Votre Nom](https://github.com/votre-utilisateur)\
📨 **Contact :** [votre-email@example.com](mailto\:votre-email@example.com)

