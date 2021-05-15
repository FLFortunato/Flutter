import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testing/Components/Login/index.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Register',
            style: TextStyle(fontSize: 36),
          ),
          RegisterForm()
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String lastName = '';
  String email = '';

  void handleChangeState(e, item) {
    if (item['label'] == 'Email') {
      setState(() {
        email = e;
      });
    }
    if (item['label'] == 'FirstName') {
      setState(() {
        name = e;
      });
    }
    if (item['label'] == 'LastName') {
      setState(() {
        lastName = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleOnSubmit() {
      if (_formKey.currentState!.validate()) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data')));
      }
    }

    List widgetsList = [
      {
        "label": "FirstName",
        "error": "Name must have at least 5 characters",
      },
      {
        "label": "LastName",
        "error": "Name must have at least 5 characters",
      },
      {
        "label": "Email",
        "error": "E-mail is required",
      },
      {"label": "Send", "error": "Name must have at least 5 characters"},
    ];
    return Form(
      key: _formKey,
      child: Column(
        children: widgetsList.map((item) {
          if (item['label'] == 'Send') {
            return SizedBox(
              width: 800.0,
              child: ElevatedButton(
                onPressed: handleOnSubmit,
                child: Text('Send'),
              ),
            );
          }
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                  decoration: InputDecoration(labelText: item['label']),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return item['error'];
                    }

                    return null;
                  },
                  onChanged: (e) => handleChangeState(e, item)));
        }).toList(),
      ),
    );
  }
}
