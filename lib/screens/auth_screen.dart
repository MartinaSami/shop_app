import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:provider/provider.dart';

//import 'auth_card.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                        Color.fromRGBO(0, 128, 250, 1).withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 1])),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: deviceSize.width > 600 ? 2 : 1,
                        child: AuthCard()),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'email is already exist';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'email is already exist';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'email not found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'wrong password';
      }
      else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'wrong email';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'something went wrong with authentication';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text("An Error occurred"),
            content: Text(errorMessage),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text("okay"))
            ],
          ),
    );
  }

  void _switch() {
    if (_authMode == AuthMode.SignUp) {
      setState(() {
        _authMode = AuthMode.Login;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _authData['email'] = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  controller: _passwordController,

                  //key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter at valid password";
                    }
                    return null;
                  },

                  onSaved: (val) => _authData['password'] = val,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                if (_authMode == AuthMode.SignUp)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      enabled: _authMode == AuthMode.SignUp,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: _authMode == AuthMode.SignUp
                        ? (val) {
                      // ignore: missing_return
                      if (val != _passwordController.text) {
                        return 'password do not match';
                      }
                      return null;
                    }
                        : null,
                  ),

                SizedBox(
                  height: 20,
                ),
                if (isLoading) CircularProgressIndicator(),
                // ignore: deprecated_member_use
                RaisedButton(
                  child: Text(_authMode == AuthMode.Login ? 'Login' : 'SignUp'),
                  onPressed: submit,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  textColor: Theme
                      .of(context)
                      .accentTextTheme
                      .headline6
                      .color,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(_authMode == AuthMode.Login ? 'SignUp' : 'Login'),
                  onPressed: _switch,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  textColor: Theme
                      .of(context)
                      .accentTextTheme
                      .headline6
                      .color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
