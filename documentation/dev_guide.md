# Introduction

This section provides an overview of the development sections involved in this project.


# Folder Organisation

The code is abstracted into 3 main folders contained in `lib/`.

1. screens  - contains the UI logic.
2. widgets  - contains reusable widgets.
3. utils    - contains encapsulated business logic.

To illustrate:  
1. `screens/main.dart` calls up `screens/my_home_page.dart`.
2. `screens/my_home_page.dart` displays the page according to the navbar. Suppose `screens/dashboard_page.dart` is chosen.
3. `screens/dashboard_page.dart` encapsulates the UI logic. It will display habits, if any. Else, it will show a text indicating that there are no habits.
4. Users may interact with the habits that they have added, or deleted. The logic is contained within `utils/habit_manager.dart`.
5. The process of interacting with habits calls upon other widgets to appear to facilitate this interaction. These includes the widgets in `widgets/*`, which contains the dialogs for interacting with the habits.


# Testing

The tests files are contained in the `test/` directory.

You may run the following command to run all tests.
```
flutter test
```


# CI/CD

This project has been configured to utilise GitHub Actions to automatically run tests on every push to the repo.

This will further guarantee the code integrity of the project.

