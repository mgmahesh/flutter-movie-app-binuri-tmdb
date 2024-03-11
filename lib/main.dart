import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/client/firebas_auth.dart';
import 'package:movie_app_example/constants/colors.dart';
import 'package:movie_app_example/firebase_options.dart';
import 'package:movie_app_example/screens/Home/home_screen.dart';
import 'package:provider/provider.dart';

import 'components/show_dialog.dart';
import 'db/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  DatabaseHelper dbHelper = DatabaseHelper();
  // int id = await dbHelper.insertMovie(movie);

  var kjjjkk = await dbHelper.getMovies();

  // Now, you can print movie titles
  for (var movie in kjjjkk) {
    print(movie.title);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scaffoldBgColor,
          useMaterial3: true,
        ),
        home: HomeScreenWithNetworkCheck(),
      ),
    );
  }
}

class NetworkAwareWidget extends StatefulWidget {
  final Widget child;

  const NetworkAwareWidget({Key? key, required this.child}) : super(key: key);

  @override
  _NetworkAwareWidgetState createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = (result != ConnectivityResult.none);
      if (!_isConnected) {
        showCustomDialog(context,
            title: 'No Internet Connection',
            content: 'Please check your internet connection and try again.',
            buttonText: 'OK');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected ? widget.child : SizedBox();
  }
}

class HomeScreenWithNetworkCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      child: const HomeScreen(),
    );
  }
}
