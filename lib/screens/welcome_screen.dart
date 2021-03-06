import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/push_notifications.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/login_register_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/scheduler.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationContoller();
    isUserLoggedIn();
  }

  void isUserLoggedIn() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(ChatScreen.id);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void animationContoller() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/whatsapplogo.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 300),
                  isRepeatingAnimation: false,

                  onTap: () {},
                  text: [
                    "Konnect",
                  ],
                  textStyle: kWelcomeScreenHeadinTextStyle,
                  // or Alignment.topLeft
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LoginRegisterWidget(
              color: Colors.white,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Log In',
            ),
            LoginRegisterWidget(
              color: Colors.white,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
