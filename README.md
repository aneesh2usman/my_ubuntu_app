# my_ubuntu_app

A new Flutter project.

## Getting Started
flutter run -d linux

## Run Code Generation: Run this command in your terminal:
flutter pub run build_runner build --delete-conflicting-outputs

flutter pub run drift_dev schema generate schemas/schema.drift


dart run drift_dev schema generate /home/aneesh/Documents/flutter/my_ubuntu_app/schemas/schema.drift /home/aneesh/Documents/flutter/my_ubuntu_app/schemas/




your_project/
  lib/
    data/
        db/
            app_database.dart   # Your database class

migrations/
    schema_v4.dart
    schema.dart  

dart run drift_dev schema dump lib/data/db/app_database.dart lib/data/db/schemas

dart run drift_dev schema generate lib/data/db/schemas lib/data/db/migrations/