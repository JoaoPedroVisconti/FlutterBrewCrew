# Brew Crew App:

# Connect With Firebase:

- Create a new Firebase project in there website

- Add an Android app to the project

  - On Android Package Name field, we need to place the the *applicationId* property the we have inside the 'android/app/build.gradle'
  
  - I did change the name to make a little bit better

```gradle
defaultConfig {
    // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
    applicationId "com.viscfirstapp.brew_crew" // ***
    minSdkVersion 16
    targetSdkVersion 29
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

- Can register the app now

- Download the 'google-services.json' file, and place it inside the 'android/app/' directory.

- Place some lines of code inside the 'build.gradle' **BUT IN THE PROJECT ROUTE** 'android/build.gradle'

  - Changed the version to 4.0.1, to make compatible with the version used in the Tutorial
  
  - Inside dependencies place it:

  ```gradle
    dependencies {
        classpath 'com.android.tools.build:gradle:3.5.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.0.1'
    }
  ```

- Add a couple of lines in the file 'android/app/build.gradle', at the bottom of all the code.

```gradle
apply plugin: 'com.google.gms.google-services'
```

- Change the minSdkVersion to 21

```gradle
defaultConfig {
    // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
    applicationId "com.example.brew_crew"
    minSdkVersion 21 // ****
    targetSdkVersion 29
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

- Now run the application with the emulator and see if everything are correct
  
  - The Flutter application are now connected to the Firebase backend

- Click next in the setup 

## Install Firebase Packages:

1. First is the authentication package: 'https://firebase.flutter.dev/docs/auth/overview'

  - Add to the pubspec.yaml the line, inside the dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_auth: "^0.18.1+2"
```

2. cloud Firestore: 'https://pub.dev/packages/cloud_firestore/install'

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_auth: ^0.18.1+2
  cloud_firestore: ^0.14.2
```

# Basic App Structure:

Build a Diagram to see how the flow inside the App are going to work: 'https://app.diagrams.net/#' -> good website to do it.

Create a new folders to start organize the app structure

1. screens (folder): All of the widgets that make different screens are going to inside this folder.

  - Create different sub folders for the different sections of the app.

  1. home (folder): All different widgets that go to create the Home page are going to be here:
     
    1. home.dart (file): Not going to use state directly inside this widget, so it going to be a **StatelessWidget**

      - just import the *material* from now

      ```dart
      import 'package:flutter/material.dart';
      ```
      - Create a **StatelessWidget** call 'Home'. Lets return just a **Container** with a **Text**

  ```dart
  import 'package:flutter/material.dart';

  class Home extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Text('Home screen'),
      );
    }
  }
  ```


  2. authenticate (folder): All different widgets to the Authenticate screen are going to be here

    1. authenticate.dart (file): That are going to be the route authentication widget

      - just import the *material* from now

      ```dart
      import 'package:flutter/material.dart';
      ```
      - Create a **StatefulWidget** call 'Authenticate'. Lets return just a **Container** with a **Text**

  ```dart
  import 'package:flutter/material.dart';

  class Authenticate extends StatefulWidget {
    @override
    _AuthenticateState createState() => _AuthenticateState();
  }

  class _AuthenticateState extends State<Authenticate> {
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Text('Authenticate Screen'),
      );
    }
  }
  ```

- Now underneath the Root component that is 'main.dart' it has a **Wrapper** component which listens for Auth changes, and it going to show the Home or the Authenticate screens (widgets)

 - screen (folder): 

 1. wrapper.dart (file): Not going to use directly state inside this widget

  - import materials

  - create a **StatelessWidget** call Wrapper

  - we want to return either the Home or Authenticate widget. (Need to import this two widgets to this file)

```dart
import 'package:brew_crew/screens/authentication/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return Home or Authenticate widget
    return Home();
  }
}
```

- In main.dart delete all the code inside the **MaterialApp** and teh rest of the code bellow.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
```

- Letting the root widget been the **MyApp**

- Inside the **MaterialApp** place the **Wrapper** widget in a *home* property. (Need to import the **Wrapper** widget)

```dart
import 'package:brew_crew/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
```


# Firebase Auth:

Enable the authenticate methods in the Firebase project. 
  
- Enable both methods: Email/Password and Anonymous on the Firebase website under the Authentication part.

Now inside the App set a separate class inside that going to handle all the different authentication cases:
  1. Sign In
  2. Sign Out
  3. Register

Create a new folder inside the 'lib' folder to hold all the services, call 'services'

- services (folder): 

  1. auth.dart (file): Use the Firebase auth package that was install.

  ```dart
  import 'package:firebase/firebase.dart';
  ```