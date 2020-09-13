<h1 align="center">Welcome to Flutter Train Booking Admin 👋</h1>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0.-blue.svg?cacheSeconds=2592000" />
  <a>
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" target="_blank" />
  </a>
  <a>
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" target="_blank" />
  </a>
  <a href="http://makeapullrequest.com">
    <img alt="PRs welcome: alianilkocak" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" target="_blank" />
  </a>
  <a href="https://linkedin.com/in/harshana-rathnayaka">
  <img alt="LinkedIn" src="https://img.shields.io/badge/-LinkedIn-black.svg?&logo=linkedin&colorB=555" />
  </a>
</p>

***Star ⭐ the repo if you like what you see. 😎***

> ***An admin app made with Flutter for a train ticket booking system in Sri Lanka***

## 📃 Features

 - Dark Mode
 - Create new train schedules
 - Add new trains
 - Add new Journeys 
 - Delete train schedules
 - Remove a train 
 - Remove a journey 
 - Get the total user count
 - Get the total revenue 

## 👷‍♂️ Built With

* [Flutter](https://flutter.dev)
* [Firebase](https://firebase.google.com/)
* [Razorpay](https://razorpay.com)

## ✨ Requirements
* Any Operating System (ie. MacOS X, Linux, Windows)
* Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc.)
* A Firebase account
* A little knowledge of Dart and Flutter

## 🔨 Installation

- Follow the below steps to get up and running
- Run the following `commands` inside Visual Studio Code or any other IDE which has a terminal or you can just use `cmd`

> 👯 Clone the repository

- Clone this repo to your local machine using `https://github.com/Harshana-Rathnayaka/Online-Train-Ticket-Booking-Admin-App`

```shell

$ git clone https://github.com/Harshana-Rathnayaka/Online-Train-Ticket-Booking-Admin-App

```

> 🔥 Add to Firebase
- Create a new project
- Add the app to the project by providing the relevant details and the below package name

```

com.example.flutter_train_admin

```

- Download the `google-services.json` file and add it to the project's `app` directory
- Add the following lines to the project level `build.gradle` file (`<project>/build.gradle`)

```gradle

buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
  }
  dependencies {
    ...
    // Add this line
    classpath 'com.google.gms:google-services:4.3.3'
  }
}

allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
    ...
  }
}

```

- Add the following lines to the app level `build.gradle` file (`<project>/<app-module>/build.gradle`)

```gradle

apply plugin: 'com.android.application'
// Add this line
apply plugin: 'com.google.gms.google-services'

dependencies {
  // add the Firebase SDK for Google Analytics
  implementation 'com.google.firebase:firebase-analytics:17.5.0'
  // add SDKs for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}

```

- Save the files

> 🏃‍♂️ Run and test the application
- Run the following commands to run and test the application in an emulator or a real device

```dart

$ flutter pub get
$ flutter run

```

## 📸 Screenshots
| Light| Dark|
|------|-------|
|<img src="assets/images/light-1.png" width="400">|<img src="assets/images/dark-1.png" width="400">|
|<img src="assets/images/light-2.png" width="400">|<img src="assets/images/dark-2.png" width="400">|
|<img src="assets/images/light-3.png" width="400">|<img src="assets/images/dark-3.png" width="400">|
|<img src="assets/images/light-4.png" width="400">|<img src="assets/images/dark-4.png" width="400">|
|<img src="assets/images/light-5.png" width="400">|<img src="assets/images/dark-5.png" width="400">|
|<img src="assets/images/light-6.png" width="400">|<img src="assets/images/dark-6.png" width="400">|
|<img src="assets/images/light-7.png" width="400">|<img src="assets/images/dark-7.png" width="400">|
|<img src="assets/images/light-8.png" width="400">|<img src="assets/images/dark-8.png" width="400">|
|<img src="assets/images/light-9.png" width="400">|<img src="assets/images/dark-9.png" width="400">|
|<img src="assets/images/light-10.png" width="400">|<img src="assets/images/dark-10.png" width="400">|


## 🤓 Author
**Harshana Rathnayaka** 
<br>
<img href="https://facebook.com/DiloHashRoX" src="https://img.shields.io/badge/facebook-%231877F2.svg?&style=for-the-badge&logo=facebook&logoColor=white">

## 🤝 Contributing

**Contributions, issues and feature requests are welcome** !<br />Feel free to check out the [issues page]().

## 📝 License

<img alt="License: MIT" href="http://badges.mit-license.org" src="https://img.shields.io/badge/License-MIT-yellow.svg" target="_blank" />

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2020 © <a href="http://fb.com/DreekoCorporations" target="_blank">Dreeko Corporations</a>

## 🧑 Train Ticket Booking User Application
`https://github.com/Harshana-Rathnayaka/Online-Train-Ticket-Booking-User-App`

