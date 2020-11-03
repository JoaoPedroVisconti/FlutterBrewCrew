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
  
  - We set up a Stream so that every time a user sign in or sings out, it get some kind of response down this Stream. (Some kind of event to tell: 'this is the user that signs in or null if the user signs out')

  - So Map that in the custom user, so that TheUser object is what came back to our app. So it can use this object.

```dart
//Auth change user Stream
Stream<TheUser> get user {
  return _auth
      .authStateChanges()
      // .map((User user) => _userFromFirebaseUser(user))  // Is the same as
      .map(_userFromFirebaseUser);
}
```


# Provider Package:

Now that the auth Stream setup, we need to use in the root of the application. In the top of the app the user state are track, so that inside the **Wrapper** widget the app make the decision of going to the Authentication screen or the Home screen.

Now we need to provide the data that comes back from the Stream (a valid **TheUser** object or *null*) to the root widget (**MyApp**). This are going to be done with a package call Provider (Google recommended solution for State manage in Flutter).

The way this package works is that, we can wrap a widget tree in a **Provider** supplying a Stream to that **Provider**, then whenever it get a new data in that Stream the **Provider** makes accessible to any of its descendent in the widget tree

> Need to install the package: 'https://pub.dev/packages/provider/install'

- In the main.dart file wrap the **MaterialApp** with the **Provider** (Don't forget to import it), to pass the information to the **Wrapper** widget where the data is used. The Provider that we are going to use is a **StreamProvider**.

  - I going to be use a method of the **StreamProvider** call *value*. Inside it can be specify what stream it wants to listening.

  - The stream that we are going to listen are inside the **AuthService** class and need to access the user stream on it. (Create an instance of this class and access the user stream on it) (Don't forget to import the auth.dart file to access the class)

  - Now the **StreamProvider** is listening to the Stream and wrapping the **MaterialApp**. That means that everything inside this **MaterialApp*, every descendent have access to the data provide by the Stream.

- One thing missing, it needs to specify what kind of data tha Stream a listening to, in this case **TheUser** type. (Has to import this as well)

```dart
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
```

- Now inside the wrapper.dart file, use the Provider package accessing a method call *.of* and specifying the type of data it trying to receive, and store this information in a *final* variable.

```dart
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authentication/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    print(user);

    // Return Home or Authenticate widget
    return Authenticate();
  }
}
```


# Signing Out:

First of all it need a check in the wrapper.dart file to see if the user are login or not to see which screen to show.

```dart
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    // print(user);

    // Return Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
```

Now the Home screen need a button to sign out and show the Authenticate screen again.

- Lets return for the Home screen a **Scaffold** widget with an **AppBar** inside it.

```dart
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Brew Crew'),
        elevation: 0,
      ),
    );
  }
}
```

- Lets set a new property for the **AppBar** call *actions*

  - *actions* expects a Widget list that represent little buttons that going to appear inside the app bar.

```dart
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Brew Crew'),
        elevation: 0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
```

- The first widget is a **FlatButton.icon** to logout. The action of logout is done inside the *onPressed* property of the button.

  - First we need to create this method of logout inside the auth.dart file.

  - It is a async task so it going to return a *Future*. And inside has a Try Catch block.

  - There is a method call *signOut()* inside the Firebase auth library

```dart
// Method to Sign Out
Future signOut() async {
  try {
    return await _auth.signOut();
  } catch (err) {
    print(err.toString());
    return null;
  }
}
```

- Now this method can be use inside the home.dart file in the button

  - To access this method first need to create the instance of the **AuthService** class. (store in a final variable)

```dart
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Brew Crew'),
        elevation: 0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
```


# Sign In & Register Forms:

Create the register form with email and password

- Delete the content of the **Container** *child* inside the sign_in.dart file. And replace it with a **Form** widget

- The child of the widget are going to be a **Column** and inside we going to have different form fields.

  - TextFormField: takes a property call *onChange*, set that equal to a function which takes in the value.

  - For the password field, it is the same but with another property call *obscureText* set to true.

```dart
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

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
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                onChanged: (val) {},
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onChanged: (val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- Now it can add a button that has a async function on *onPressed* property, because this future are going to interact with the Firebase.

```dart
children: <Widget>[
  SizedBox(height: 20),
  TextFormField(
    onChanged: (val) {},
  ),
  SizedBox(height: 20),
  TextFormField(
    obscureText: true,
    onChanged: (val) {},
  ),
  SizedBox(height: 20),
  RaisedButton(
    color: Colors.pink[400],
    child: Text(
      'Sign In',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onPressed: () async {},
  )
],
```

- Now the form needs to keep track of what the user is typing in, and store this values of those fields inside a local state variable.

- Create two peaces of state to store this two fields. So when the user start typing in the field, the state are update to the value of this field.

```dart
class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

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
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  print(email);
                  print(password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

Now that the sign in form are done, create the register form that are going to be something very similar.

- Create new file call 'register.dart' inside the 'authentication' folder.
  
  - import material and create a **StatefulWidget** call Register.

```dart
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
```

- Can copy all the return of the **build()** function from the sign_in.dart file, the state and the instantiation of the *_auth* object
  
  - The *_auth* object is not in use yet but it is needed in both files.

```dart
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Register to Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  print(email);
                  print(password);
                },
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
```


# Toggle Between Forms:
