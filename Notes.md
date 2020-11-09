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

Create a link to switch between the Resister and Sign In screens

- Add the *action* property to the app bar, the list of widgets in this case is going to be one widget **FlatButton.icon**

  - Do this for both Register and Sign In screen

```dart
appBar: AppBar(
  backgroundColor: Colors.brown[400],
  elevation: 0,
  title: Text('Register to Brew Crew'),
  actions: [
    FlatButton.icon(
      onPressed: () {},
      icon: Icon(Icons.person),
      label: Text('Sign In'),
    )
  ],
),
``` 

- Need a piece of state inside the **Authenticate** widget to show one page or the other, a boolean. And do a check to see if it is true or false.

  - Now lets create a function that toggle between true and false of this state.

```dart
import 'package:brew_crew/screens/authentication/register.dart';
import 'package:brew_crew/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
```

- Now we need to pass this function down as a parameter for the widgets that are been returned.

  - Pass as a parameter call 'toggleView: '

```dart
@override
Widget build(BuildContext context) {
  if (showSignIn) {
    return SignIn(toggleView: toggleView);
  } else {
    return Register(toggleView: toggleView);
  }
}
```

- Now inside the Widget **Register** and **SignIn** we need to create the constructor that going to receive the property.

```dart
class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}
```
> Do the same to the **SignIn** widget

- To access this *toggleView* property inside the *onPressed* property of the button we call it from the *widget.toggleView()*, because we are accessing the widget it self on top, and the property of it.

```dart
FlatButton.icon(
  onPressed: () {
    widget.toggleView();
  },
  icon: Icon(Icons.person),
  label: Text('Register'),
)
```

# Register With Email & Password:

Make the user register with an email and a password with the Firebase auth library, rather than Anonymously.

- First need to check if the user are typing something in the form field. 

  - Going to use some of the Flutters build in validation features

  - First need to define a form key, that are going to be a GlobalKey of type FormState.

    - This key is used to identify the form and the form are associate with the Global Form State key.

    - This basically is keeping track of the form and the state of the form, and help to validate it.

```dart
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>(); ***

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
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey, ***
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

- Inside the *onPressed* property now has to have a check, if the form is valid at the point that the user click the *Register* button

  - The *_formKey* is used, accessing a user property call 'currentState' to access the current state of the form, and use a method call 'validate()' this validate the form based on it current state. Return True or False

```dart
onPressed: () async {
  if (_formKey.currentState.validate()) {
    print(email);
    print(password);
  }
},
```

- For the validation method work, it use a different *validator* properties in the different forms.

  - This *validator* property allow to run a function to see if the form is valid. This function takes the current value of the form and return a *null* if the form is valid and a String (Helper text) if the from is nt valid.

```dart
children: <Widget>[
  SizedBox(height: 20),
  TextFormField(
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
    onChanged: (val) {
      setState(() {
        email = val;
      });
    },
  ),
  SizedBox(height: 20),
  TextFormField(
    obscureText: true,
    validator: (val) =>
        val.length > 6 ? 'Enter a Password 6+ Chars Long' : null,
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
      if (_formKey.currentState.validate()) {
        print(email);
        print(password);
      }
    },
  )
],
``` 

- With the validation working, the user can be register in the Firebase.

- Has to create a method inside the auth.dart file to register the user with an email and a password. This function returns a *Future* and it going to take two arguments (email and password as a string).

- This function also are going to be *Async* 

- And it has a Try Catch Block

- The Try is going to make a request to Firebase, this is done due to the Firebase Auth instance.

  - Has to *await* to this request to end and store it in a variable of type *Auth Result* call *result*.

    - It uses a method call **createUserWithEmailAndPassword()** inside the instance of Firebase Auth, passing two arguments, the email and the password that are receive from the function.

  - Now that the result is back and store, the Firebase User can be accessed from it and store in a variable call *user*

    - This is going to be converted into the custom user *TheUser* that was created before.

```dart
// Method to Register Email and Password
Future registerWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return _userFromFirebaseUser(user);
  } catch (err) {
    print(err.toString());
    return null;
  }
}
```

- Now this function can be used in the register.dart file, to register the information in the forms.

  - When it is used in the register it get something back (null or user) so it need to be store in a *dynamic* variable that going to be equal to the instance accessing this new method that was created.

  - This method accept and email and a password that currently are in the state of the class.

```dart
onPressed: () async {
  if (_formKey.currentState.validate()) {
    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
  }
},
```

- If the result is *null* something give an error, so create a peace of state call *error* to grab this information

```dart
String email = '';
String password = '';
String error = '';
```

- Now need to check if the result is *null*, if it is update the *error* state.

```dart
onPressed: () async {
  if (_formKey.currentState.validate()) {
    dynamic result = await _auth.registerWithEmailAndPassword(
        email, password);
    if (result == null) {
      setState(() {
        error = 'Supply a valid Email';
      });
    }
  }
},
```

- Lets show this error bellow the button

```dart
RaisedButton(
  color: Colors.pink[400],
  child: Text(
    'Register',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  onPressed: () async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.registerWithEmailAndPassword(
          email, password);
      if (result == null) {
        setState(() {
          error = 'Supply a valid Email';
        });
      }
    }
  },
),
SizedBox(height: 12),
Text(
  error,
  style: TextStyle(color: Colors.red, fontSize: 14),
),
```

# Sign in With Email & Password:

For Sign In a user is quite the same as Register

- Copy and paste the code

  - Need the _formKey
  
  - the *error* state

  - add *key: _formKey* to the form

  - Validation functions for email and password

  - Check if the form is valid inside the **onPressed** property. 

    - Has to change the function to register the user, we now want to sign in

  - Place to show the error in the bottom of the button.

```dart
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign In Brew Crew'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a Password 6+ Chars Long' : null,
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
                  if (_formKey.currentState.validate()) {
                    print('valid');
                    // if (result == null) {
                    //   setState(() {
                    //     error = 'Supply a valid Email';
                    //   });
                    // }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- Now has to create the method to Sign In with email and password inside the auth.dart file. To replace the print and use the comment code in the *onPressed* property

  - We can copy the code for the Register with email and password function, because it going to be almost identical.

  - Change the name of the function

  - Change the method inside the instance to **signInWithEmailAndPassword**

```dart
// Method to Sign In Email and Password
Future signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return _userFromFirebaseUser(user);
  } catch (err) {
    print(err.toString());
    return null;
  }
}
```

- Now lets use this method inside the **SignIn** widget

```dart
onPressed: () async {
  if (_formKey.currentState.validate()) {
    dynamic result =
        await _auth.signInWithEmailAndPassword(email, password);
    if (result == null) {
      setState(() {
        error = 'Could Not Sign In With Those Credentials';
      });
    }
  }
},
```


# Text Input Decoration:

To decorate the form field inside the app, add a property call *decoration*
  
  - It is going to be equal to **InputDecoration** widget this has a feel properties.

    - To use *fillColor* it is needed to enable *filled* property

```dart
TextFormField(
  decoration: InputDecoration(
    hintText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.pink,
        width: 2,
      ),
    ),
  ),
  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
  onChanged: (val) {
    setState(() {
      email = val;
    });
  },
),
```

- This is the decoration for the Email field. That can be copy to other fields. But when something change, has to comeback to each one and change it.

- So define the *decoration* code as a constant and use in various parts.

  - Create a new folder inside the lib folder call 'shared', this are going to hold any kind of shared code.

  - Create new file call 'constants.dart', hold everything that are going to use in different parts of the app and don't change.

  - import material

  - Create a new constant call *textInputDecoration* and set it equal to the code that was written for decoration.

> The *Colors* property was change for be using a *const* variable.
> I didn't like the color so it was changed to white

```dart
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color(0xFFBCAAA4),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFBCAAA4),
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2,
    ),
  ),
);
```

- The *hintText* property is remove, because it is going to be different for each part that we use. Instead, when we make the *decoration* property equals to this constant, it is passed together a method call *copyWith* and pass to the method the property that we want to add to the constant


```dart
TextFormField(
  decoration: textInputDecoration.copyWith(hintText: 'Email'),
  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
  onChanged: (val) {
    setState(() {
      email = val;
    });
  },
),
SizedBox(height: 20),
TextFormField(
  decoration: textInputDecoration.copyWith(hintText: 'Password'),
  obscureText: true,
  validator: (val) =>
      val.length < 6 ? 'Enter a Password 6+ Chars Long' : null,
  onChanged: (val) {
    setState(() {
      password = val;
    });
  },
),
```

# Loading Widget:

Load a loading screen while the request is made. 'https://pub.dev/packages/flutter_spinkit'
  - Install the spinkit package

- Create this widget inside the 'shared' folder because it going to be used in various widgets. Create loading.dart file.

- It is going to be a **StatelessWidget**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50,
        ),
      ),
    );
  }
}
```

- Need to create a property in state that it is going to be a boolean call *loading* with initial value of 'False'

  - When the **loading** property is 'true' instead of showing the content inside the **Scaffold** widget, the **Loading** widget is showed.

  - When we click the button, it is set it to 'true'. When the response come back and we get an error, we want to show the form page again, so set the *loading* equal to 'false'.

```dart
class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false; ***

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign In Brew Crew'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a Password 6+ Chars Long' : null,
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
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true); ***
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could Not Sign In With Those Credentials';
                        loading = false; ***
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- Now use a ternary operator on the **build** method to return if the *loading* is true, the Loading screen or else the form

  - Do the same thing to the **Register** widget

```dart
@override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
        
        // ---------------
        
        )
```


# Firestore Database Setup:

Create a new FireStore Database in the Firebase website, remember to change the preference of the initial to be **Start in Test Mode**

This package was already installed in the application, just use it.

- Create a file inside the 'services' folder call database.dart. Fist thing is to import the firestore database

- Create a call call **DatabaseService** inside is going to have all the different methods and properties that are going to be used to interact to the FireStore Database

  - First thing TODO is a Collection Reference, a reference to a particular collection in the FireStore database
    
    - First collection reference are going to be to the brew collections

    - This are going to be equal to a Firestore instance, and then can reference to a specific collection inside the Firestore database. (Don't need to create this collection inside the Firestore website, when this code runs, this collection are going to be created automatically).

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection Reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
}
```

# Firestore User Records:

Whenever the user register we have to communicate to firestore to add a new [document] into the {brews} collection which represents that user data and brews preferences. Going to start with a dummy data as 0 sugars and 0 strength, and the user are going to update later. Each of this documents are going to have different properties like, 'name', 'sugars' and 'strength' for example.

Now it is needed to link the Firebase User to his particular Document in Firestore. When the user register, automatically the Firebase give him an unique ID, this are going to be used in the Firestore inside the Document of this particular user.

- Create a function inside the **DatabaseReference** class to create a new document for the user that just register, inside the {brews} collection, using the reference to that collection that was created before.

  - This function are going to be used twice, one when the user register, and when he update the data.

  - This function receive three parameters, sugars, name and strength

  - Is a Future returning type, with async characteristic because of the requests.

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection Reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {}
}
```

- Inside the function returns, awaiting for the response, get the {brews} collection and find a particular document with an specific ID. 

```dart
Future updateUserData(String sugars, String name, int strength) async {
  return await brewCollection.doc(uid);
}
```

- This user Id was not created yet, so we create the *uid* property, and inside a constructor we receive this parameter when the class is instantiated, as a Named Parameter

```dart
final String uid;

DatabaseService({this.uid});
```

- This document if not existed yet, the Firestore are going to create it with that *uid* that was pass, linking with the particular User.

- Now that the reference it is done, we set the data with a Map, that is going to represent the properties and the values inside the Firestore document.


```dart
Future updateUserData(String sugars, String name, int strength) async {
  return await brewCollection.doc(uid).set({
    'sugars': sugars,
    'name': name,
    'strength': strength,
  });
}
```

- Now this function need to be call when a new user register in the app.

  - In the auth.dart file, where we register with an email and password. Onces the request is successful and get the user back, before return it, we want to create this document with the user id that came back.

  - Need to await and create an instance of the **DatabaseService** passing in the uid.

  - Use the *updateUserData()* method that was created, passing in the properties.

```dart
// Method to Register Email and Password
Future registerWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;

    // Create a document in Firestore for the user with the uid
    await DatabaseService(uid: user.uid)
        .updateUserData('0', 'New Member', 100);

    return _userFromFirebaseUser(user);
  } catch (err) {
    print(err.toString());
    return null;
  }
}
```


# Firestore Streams:

Now that has data inside the Firestore it can be used to show in the screen of the app.

To do that is necessary to setup another Stream which notify of any changes on documents or any new documents in the database. 

Any type of data that get back in the Stream is going to be a Snapshot of that particular collection {brews} at that moment in time. 

That Snapshot basically is just going to be an Object which contains the current Documents and there values and properties inside the collection at that moment in time.

Is our job to get that data from the Snapshot and organize in a way that we want in our app. 

- The first thing is to setup the Stream to listen to the database inside the **Database** class.

- Set up a Stream of type *QuerySnapshot*, this is a snapshot of the Firestore collection in time when something changes.
  
  - This is a *get* and it need to name it. 

  - and inside it need to return a Stream.

```dart
class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Get brews Stream:
  Stream <QuerySnapshot> get brews {
    return
  }
}
```

- Now the *brewCollection* Collection Reference that was created can be used to access the {brews} collection. And use a method build in the Firestore library call *snapshot()*

```dart
// Get brews Stream:
Stream<QuerySnapshot> get brews {
  return brewCollection.snapshots();
}
```

- This now returns a Stream, and can be used in the home screen. 

- Inside the home.dart file, we can use the provider package to listen to that Stream that was created inside this Home screen.

  - Need to import the Provider package and the database.dart file.

  - To use the *QuerySnapshot* type, the Firestore package has to be imported as well.

```dart
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
```

- Now the Provider can be used to wrap the **Scaffold**. The widget used to wrap is the **StreamProvider** and its type is *QuerySnapshot* that is the type that we get back down the Stream.

  - We need to do '.value' to specify what value of this Stream going to be, and add a property call *value* that are going to be equal to the Stream that we create in the **DatabaseService** class. To access this Stream the instance of this class is needed

```dart
@override
Widget build(BuildContext context) {
  return StreamProvider <QuerySnapshot>.value(
    value: DatabaseService().brews,
    child: Scaffold(
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
    ),
  );
}
```

- Now it is specified that we want this Stream 'brews' to be used and to wrap the rest of the widget three. Now in descendent widget the data can be access.

- Create a *body* property for the **Scaffold** widget, and nest a new widget that are going to be created call **BrewList**.

```dart
import 'package:brew_crew/screens/home/brew_list.dart';

//-----------------------

@override
Widget build(BuildContext context) {
  return StreamProvider<QuerySnapshot>.value(
    value: DatabaseService().brews,
    child: Scaffold(
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
      body: BrewList(),
    ),
  );
}
```

- Create the brew_list.dart file inside the home folder. This are going to be responsible to cycling through the different brews.

  - First import somethings

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
```

- This are going to be a **StatefulWidget** because it iis going to change with time.

```dart
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
```

- Inside the State object, inside the **build** function, we are going to try to access the data from the Stream.

  - This are going to be store in a final variable call *brews*.

  - Print this variable to see if its working and how it is looks

```dart
class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot>(context);

    print(brews);

    return Container();
  }
}
```

- This returns a QuerySnapshot and is not very useful, but what it can be done is to access the documents inside that Query

```dart
class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot>(context);

    print(brews.docs);

    return Container();
  }
}
```

- This prints to the console: '[Instance of 'QueryDocumentSnapshot']'

- Now it can be cycle through the documents and print out the data inside the document


```dart
class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot>(context);

    // print(brews.docs);

    for (var doc in brews.docs){
      print(doc.data());
    }

    return Container();
  }
}
```


#

It takes a little manipulation to grab the information that it is needed, is better to map this Snapshot Stream into a Stream of custom objects which represent brews in the app, so it don't have to manipulate every time the data is needed.

So instead of receiving Snapshot from the Stream, it will be better to receive a list of Brew objects

So we need to create a Brew model, like the User model that was created before (TheUser). Then when we receive a QuerySnapshot down the Stream, we can convert that into a Brew object. 

- In the model folder create a new file call brew.dart, then inside we create a class **Brew** and inside specify what property we want this Brew to have.

```dart
class Brew {
  final String name;
  final String sugars;
  final int strength;
}
```

- This need a constructor that are going to apply values to those properties.

```Dart
class Brew {
  final String name;
  final String sugars;
  final int strength;

  Brew({this.name, this.sugars, this.strength});
}
```

- Now we need a way to convert the QuerySnapshot that we get back down the Stream to into a list of **Brew**

  - We are going to do that inside the database.dart file, this is where we currently set the Stream. We are going to create a function to get a list of **Brew** from the Snapshot. (import the Brew model)

  - This function are going to return a List type of **Brew**, call the function *_brewListFromSnapshot*

  - This function are going to receive a QuerySnapshot and return a List of Brew. So when we receive a Snapshot, this is the original data, we are going to map through that data.

    - We need to access the Documents in this Snapshot

    - The *map()* method maps the documents into another iterable. So each time around it going to perform a function for each document, this function take the document, and inside return a single **Brew** for that particular document.

  ```Dart
  // Brew list from Snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew();
    });
  }
  ```

  - The *map()* are cycling through the list of documents and we are referring to each document as 'doc'. And we can get the data from each document by using '.data()'

  - Each property of the **Brew** are going to be equal to the data that are being receive from the map

  - This is essentially a Map, in a Map we can access the key and values of a single property by passing the property Key

    - To cover the case of the user don't have a name, lets give an empty string instead (to not receive null in this property)

      - ?? - Mean, if this property doesn't exist

```dart
// Brew list from Snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Brew(
      name: doc.data()['name'] ?? '',
      sugars: doc.data()['sugars'] ?? '0',
      strength: doc.data()['strength'] ?? 0,
    );
  });
}
```

- This return a iterable, and not a List. So we need to covert it to work when we output the data in the UI.

```dart
// Brew list from Snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Brew(
      name: doc.data()['name'] ?? '',
      sugars: doc.data()['sugars'] ?? '0',
      strength: doc.data()['strength'] ?? 0,
    );
  }).toList();
}
```

- Now we have the **_brewListFromSnapshot** function and we need to call this every time we get a Snapshot in the get that we did. 

- What we can do is map this in to a new Stream. Instead of returning the QuerySnapshot, we now are going to return a List of Brew, and map the get into the function that we created.

```dart
// Brew list from Snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Brew(
      name: doc.data()['name'] ?? '',
      sugars: doc.data()['sugars'] ?? '0',
      strength: doc.data()['strength'] ?? 0,
    );
  }).toList();
}

// Get brews Stream:
Stream<List<Brew>> get brews {
  return brewCollection.snapshots().map(_brewListFromSnapshot);
}
```

- Now where we are listening to this data (home.dart file) we are now listening to a list of Brew coming in, instead of QuerySnapshots.

  - Need to change the type in the StreamProvider and import the brew.dart file.

```dart
@override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        
        // ------------------------

      )
```

- Now we are using this StreamProvider saying down the Stream, every time it has a change in the database we are going to receive a list of Brew

- Now in the **BrewList** widget we are no longer listen to QuerySnapshot anymore, we are getting a LIst of Brew

```dart
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    return Container();
  }
}
```

- Now going to use a For Each method to print ou each one.

```dart
class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    brews.forEach((element) {
      print('Brew List');
      print(element.name);
      print(element.sugars);
      print(element.strength);
    });

    return Container();
  }
}
```


# Listing Brew Data:

To display the list of Brews, we are going to create a ListView builder that allow us to create a function and return a specific template or widget three for each item in the list of the Brew List

```dart
class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    // brews.forEach((element) {
    //   print('Brew List');
    //   print(element.name);
    //   print(element.sugars);
    //   print(element.strength);
    // });

    return ListView.builder();
  }
}
```

- Inside this ListView builder we need to specify a couple of things.
  
  - The first is the Item Count that specify how many items we want to cycle through. This is equal to the length of the List.

  - The second is the item Builder, this is the function itself that are going to return some kind of template or widget three for each item inside that list.

    - This function takes the *context* and the *index* of whatever item we're currently iterating.

    - This are going to return a template (widget) that we are going to create in a separate file

    - But we are also going to pass through a property to this Widget and that is going to be the individual brew that we want to create this three around. That are going to be *brew[index]* 

```dart
class _BrewListState extends State<BrewList> {
@override
Widget build(BuildContext context) {
  final brews = Provider.of<List<Brew>>(context);

  // brews.forEach((element) {
  //   print('Brew List');
  //   print(element.name);
  //   print(element.sugars);
  //   print(element.strength);
  // });

  return ListView.builder(
    itemCount: brews.length,
    itemBuilder: (context, index) {
      return BrewTile(brew: brews[index]);
    },
  );
}
```

- Lest create a new file inside the home folder call brew_tile.dart, and import the things that we are going to use.

- This are going to be a **StatelessWidget** call BrewTile

```dart
import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

- We are going to create a final Brew property (this is defined inside the brew.dart file) call *brew*. And set this property inside the constructor (We are passing this property inside the Brew List)

```dart
import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

- Now we are getting this individual brew inside, now we can return a widget three using that individual brew.

- We are going to use a **Card** widget with a **ListTile** widget inside 'https://api.flutter.dev/flutter/material/ListTile-class.html'

```dart
return Padding(
  padding: EdgeInsets.only(top: 8),
  child: Card(
    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
    child: ListTile(),
  ),
);
```

- We are going to specify a *leading* property to be an **CirceAvatar** with a background color accordantly to the strength of the brew.

```dart
return Padding(
  padding: EdgeInsets.only(top: 8),
  child: Card(
    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
    child: ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.brown[brew.strength],
      ),
    ),
  ),
);
```

- The next property is the *title*, that is equal to the *name* property of the brew.

```dart
@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 8),
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[brew.strength],
        ),
        title: Text(brew.name),
        subtitle: Text('Takes ${brew.sugars} sugar(s)'),
      ),
    ),
  );
}
```


# Bottom Sheets:

The Home screen are going to have a button in the app bar that are going to pop-up some panel from the bottom of the screen. That panel has a form inside it that the user can update there data.

So inside the home.dart file lets create this icon button in the top bar to be clicked and show the BottomSheet.

- Create another action inside the *actions* property of the app bar

  - The function inside the *onPressed* property inside the new button, are going to invoke another function call *_showSettingsPanel* (void function)

```dart
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
    FlatButton.icon(
      icon: Icon(Icons.settings),
      label: Text('Settings'),
      onPressed: () => _showSettingsPanel(),
    )
  ],
),
```

- This function basically are going to invoke a build in function in Flutter call *showModalBottomSheet()*

  - This takes two named parameters, the *context* and the *builder*.

    - The builder is a function that actually builds the widget three or template that seats inside the bottom sheet it self.

```dart
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Text('Bottom Sheet'),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
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
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
```

 # Drop-downs:

 The bottom form are going to show a different widget, this are going to be created in a separate file.

 - Create inside the home folder the file call 'settings_form.dart'.

  - import as usual the material and the constants.dart file that has some style properties that we are going to use.

- This are going to be a **StatefulWidget** because we need to keep track of what the user types in or select in the different form fields.

  - This are going to be like the Form that we already used in the Sign In and Register.

  - Don't forget to import the settings_form.dart inside the home file and inside the **Container** child place the **SettingsForm** widget

  ```dart
  import 'package:brew_crew/models/brew.dart';
  import 'package:brew_crew/screens/home/brew_list.dart';
  import 'package:brew_crew/screens/home/settings_form.dart';
  import 'package:brew_crew/services/auth.dart';
  import 'package:flutter/material.dart';
  import 'package:brew_crew/services/database.dart';
  import 'package:provider/provider.dart';

  class Home extends StatelessWidget {
    final AuthService _auth = AuthService();

    @override
    Widget build(BuildContext context) {
      void _showSettingsPanel() {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: SettingsForm(),
              );
            });
      }

      return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
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
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: BrewList(),
        ),
      );
    }
  }
  ```

  - For the settings_form.dart file.

```dart
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  // Form Values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Update Your Brew Preference',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20),
          // TODO: Dropdown
          // TODO: Slider
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          ),
        ],
      ),
    );
  }
}
```

- Now lest use a **DropdownButtonFormField** widget to create the dropdown.

  - Inside this we need to specify a fill different things

  1. item: need to be a list of **DropdownMenuItem** widgets. 
    
    - So we are going to map through the sugars and for each item we are going to return a widget **DropdownMenuItem** which has that particular value.

```dart
TextFormField(
  decoration: textInputDecoration,
  validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
  onChanged: (val) => setState(() => _currentName = val),
),
SizedBox(height: 20),
DropdownButtonFormField(
  items: sugars.map((sugar) {
    return DropdownMenuItem();
  }),
)
```

- We need to specify to the **DropdownMenuItem** the *value* and *child* properties.

```dart
return Form(
  key: _formKey,
  child: Column(
    children: [
      Text(
        'Update Your Brew Preference',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 20),
      TextFormField(
        decoration: textInputDecoration,
        validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
        onChanged: (val) => setState(() => _currentName = val),
      ),
      SizedBox(height: 20),
      DropdownButtonFormField(
        decoration: textInputDecoration,
        value: _currentSugars ?? '0',
        items: sugars.map((sugar) {
          return DropdownMenuItem(
            value: sugar,
            child: Text('$sugar Sugars'),
          );
        }).toList(),
        onChanged: (val) => setState(() => _currentSugars = val),
      ),
      // TODO: Slider
      RaisedButton(
        color: Colors.pink[400],
        child: Text(
          'Update',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          print(_currentName);
          print(_currentSugars);
          print(_currentStrength);
        },
      ),
    ],
  ),
);
```


# Sliders:

Add a Slider widget to control the strength the brew

- Call the Slider inside the **Column** widget

  - This takes a fill different properties, a maximum and minimum number, the number of divisions, and a onChange property that update the state for the *_currentStrength* property.

    - The *val* property that we get back of the function, is a double, so we need to round it to an integer.

  - We need to set a value to initialize the slider, that are going to be either the current value of the user or 100 to initialize.

    - The properties in the Slider widget came in double, so we need to convert to it.

  - The inactive and active colors properties are for the color of the bar. We can use the value that we obtain from the strength.

```dart
SizedBox(height: 20),
Slider(
  value: (_currentStrength ?? 100).toDouble(),
  activeColor: Colors.brown[_currentStrength ?? 100],
  inactiveColor: Colors.brown[_currentStrength ?? 100],
  min: 100,
  max: 900,
  divisions: 8,
  onChanged: (val) => setState(() => _currentStrength = val.round()),
),
```


# User Data Model:

We want to populate the form with user information

For this we need to set a Stream to listen to the particular user Document. 

When the user login or register, it has a ID associated with it. Now we want to setup a Stream to the Firestore Document with that particular ID and get the data. And when is changes, are update in the form as well.

We are going to setup this Stream in the database.dart file.

And we also going to create a user data model. Every time we get some kind of document snapshot back down on our Stream we are going to take that data and put in a user data object.

