import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyLoginPageState();
  }
}

class MyLoginPageState extends State<MyLoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences loginData;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
  }

  void checkIfAlreadyLogin() async {
    loginData = await SharedPreferences.getInstance();
    newuser = (loginData.getBool('login') ?? true);
    //print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MyDashBoard()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    //Clean up the controller when the widget is disposed
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharePrefrences"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login Form',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              'To Show Example of Shared Prefrence',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;
                if (username != '' && password != '') {
                  // print('Successful');
                  loginData.setBool('login', false);
                  loginData.setString('username', username);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyDashBoard()));
                }
              },
              child: const Text(
                "Log-In",
                style: TextStyle(
                    color: Colors.white, backgroundColor: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
