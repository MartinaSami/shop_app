/*
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          )),
      //elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.SignUp ? 320 : 260,
        constraints: BoxConstraints(
          // minHeight: _authMode == AuthMode.SignUp ? 320 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(300),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      // ignore: missing_return
                      if (val.isEmpty || !val.contains('@')) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['email'] = val;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (val) {
                      // ignore: missing_return
                      if (val.isEmpty) {
                        return 'please enter a valid password';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['password'] = val;
                    }),
                Container(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    minWidth: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  child: TextFormField(
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
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentTextTheme.headline6.color,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(_authMode == AuthMode.Login ? 'SignUp' : 'Login'),
                  onPressed: _switch,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  textColor: Theme.of(context).accentTextTheme.headline6.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
