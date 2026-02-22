
# 📝 Advance To-Do App (Flutter + Sqflite)

A simple and clean To-Do List application built using Flutter and Sqflite for local database storage.
## 🚀 Features

- ✅ Add new tasks
- ✏️ Edit existing tasks
- 🗑️ Delete tasks
- 📅 Select date using Date Picker
- 💾 Persistent local storage using Sqflite
- 🎨 Beautiful UI with Google Fonts
  
## 🛠️ Technologies Used
- Flutter
- Dart
- Sqflite (Local Database)
- Path Package
- Intl Package
- Google Fonts

## 📂 Database Structure

Table Name: `todo`

| Column Name | Type |
|------------|-------|
| id | INTEGER (Primary Key, Auto Increment) |
| title | TEXT |
| description | TEXT |
| date | TEXT |

## 📱 App UI

- ListView for displaying tasks
- Modal Bottom Sheet for Add / Edit
- Floating Action Button to create task
- Local SQLite database for storing data

## 📦 Packages Used

Add these in `pubspec.yaml`:

```yaml
sqflite: ^2.3.0
path: ^1.8.3
intl: ^0.18.0
google_fonts: ^6.1.0
```
## ▶️ How to Run

1. Clone the repository: git clone  https://github.com/Viraj-Babar/To-Do-App.git
2. Run `flutter pub get`
3. Run `flutter run`

---

## 📌 Project Type

Mini Project – Flutter CRUD Application with Local Database

---

## 👨‍💻 Developed By

Viraj Babar
