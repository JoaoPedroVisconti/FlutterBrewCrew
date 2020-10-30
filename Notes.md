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

  - Create a Class **AuthService**: inside this it going to be all the different methods that are going to interact with Firebase Auth.

  ```dart
  import 'package:firebase/firebase.dart';

  class AuthService {

    // Method to Sign In Anony

    // Method to Sign In Email and Password
  
    // Method to Register Email and Password

    // Method to Sign Out
    
  }
  ```

  - First create a instance of the Firebase Authentication, and this object going to allow to communicate with Firebase Auth.

    - Create a new *final* property, this means that it is not going to change in the future.

    - The type is *FirebaseAuth* and with a '_' before the name, this means that this property is private, only can be use in this particular file (auth.dart)

    - This property are going to be equal to an instance Firebase

  ```dart
  class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

    // Method to Sign In Anony

    // Method to Sign In Email and Password

    // Method to Register Email and Password

    // Method to Sign Out

  }
  ```

- Starting with the Sign In Anonymously
  
  - This is going to be a Asynchronous task, and returns a Future (Like Promise in JavaScript)

  - This can give an error, so wrap in a Try and Catch block

```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to Sign In Anony
  Future signInAnon() async {
    try {} catch (err) {}
  }

  // Method to Sign In Email and Password

  // Method to Register Email and Password

  // Method to Sign Out

}
```
  
  - Want to get some kind of authenticated result from Firebase by making a request.
  
  - The way to make this request is via the *_auth* object

    - Need to await this request because it can take some time, before assign the result to some variable.

    - Use a method from the object *_auth* (That is a FIrebase object) call *signInAnonymously()*

    - This return a type of object call 'UserCredential'

    ```dart
    Future signInAnon() async {
      try {
        UserCredential result = await _auth.signInAnonymously();
      } catch (err) {}
    }
    ```

    - On this *result* object has a *User* type object that represent that user.

    - And it going to return that user.

    - If get some error lets print it and return null.

    ```dart
    // Method to Sign In Anony
    Future signInAnon() async {
      try {
        UserCredential result = await _auth.signInAnonymously();
        User user = result.user;
        return user;
      } catch (err) {
        print(err.toString());
        return null;
      }
    }
    ```


# Anonymous Sign In:

Do the sign in anonymously from a **SignIn** widget. 

- Create the **SignIn** widget to use the Auth service inside it. Create inside the 'authenticate' folder a file call 'sign_in.dart'

  - First of all import material

- This are going to be a **StatefulWidget** because in some time the state change.

  - This widget is going to return a **Scaffold**

  1. backgroundColor
  2. appBar: AppBar()
    1. backgroundColor
    2. elevation
    3. title
  3. body: Container()
    1. padding
    2. child: RaisedButton()
      1. child: Text()
      2. onPress: async function
    
```dart
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign In Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: RaisedButton(
          child: Text('Sign In Anon'),
          onPressed: () async {},
        ),
      ),
    );
  }
}
```

- Now we can return the **Authenticate** widget inside the **Wrapper** widget and return the **SignIn** widget in the **Authenticate** widget.

- The function of the button inside the **SignIn** widget has to access the method *signInAnon* inside the **AuthService** class. Have to create an instance to have access to this method.

  - Create a final variable with type 'AuthService' name of the class to hold the instance of this class. Can call whatever, but call it '_auth'. This are going to be equal to the instance.

  - The *signInAnon()* method can be used inside the *onPressed* property of the button. But has to await because of the request.

    - Store that in a dynamic variable (because could be null or could be a Firebase user)

  ```dart
  onPressed: () async {
    dynamic result = await _auth.signInAnon();
    if (result == null) {
      print('Error signing in');
    } else {
      print('User sign in');
      print(result);
    }
  },
  ```

> The code has an error: No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp() 
>
> Solution:
>
> 1. Add to pubspec.yaml
>
> firebase_core: ^0.5.0
>
> 2. Add to main.dart
>
> ```dart
> import 'package:firebase_core/firebase_core.dart';
>
> void main() async {
>   WidgetsFlutterBinding.ensureInitialized();
>   await Firebase.initializeApp();
>   runApp(MyApp());
> }
> ```


# Custom User Model:

Cleaning up the data that comes back from the request of the user (User Firebase). Just need the 'uid' property, User Id

- Create a new TheUser object, custom with the needed information, and turn this Firebase User object into it.

- Need to create a new TheUser class to base this user models on

- Create a new folder call 'models'. Create a user model, file call user.dart

  - This are going to be a simple call TheUser, that specify what properties the object user has.

  - Has also a constructor to set the properties to some value. (Named Parameters)

  ```dart
    class TheUser {
    final String uid;

    TheUser({this.uid});
  }
  ```

- Inside the auth.dart file, we need to set the Firebase user to be the new TheUser class

  - Create a new function that create a TheUser object based on a Firebase User.

  ```dart
  // Create an User based on Firebase User
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }
  ```

- Call the function from where returns a Firebase User

```dart
// Method to Sign In Anony
Future signInAnon() async {
  try {
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;
    return _userFromFirebaseUser(user);
  } catch (err) {
    print(err.toString());
    return null;
  }
}
```

- Now we can print out inside the sign_in.dart file.

```dart
onPressed: () async {
  dynamic result = await _auth.signInAnon();
  if (result == null) {
    print('Error signing in');
  } else {
    print('User sign in');
    print(result.uid);
  }
},
```

# Streams:

Have to listen for when get the user back. To do this we are going to use a Stream. This occurs inside the **Wrapping** widget. (Show the **Authenticate** widget or the **Home**)

- Set up a Stream inside the auth.dart file

