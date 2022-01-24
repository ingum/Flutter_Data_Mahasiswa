import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';

import 'controller/form_controller.dart';
import 'model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Data Mahasiswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          nimController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text);

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                          )),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0),),
                      TextFormField(
                        controller: nimController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Nim';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nim',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                          )),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0),),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (!value.contains("@")) {
                            return 'Enter Valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                          )),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0),),
                      TextFormField(
                        controller: mobileNoController,
                        validator: (value) {
                          if (value.trim().length != 10) {
                            return 'Enter 10 Digit Mobile Number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'No Handphone',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                          )
                        ),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0),),
                      TextFormField(
                        controller: feedbackController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Alamat';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)
                          )),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Tambah Data'),
            ),
            new Padding(padding: new EdgeInsets.only(top: 20.0),),
            RaisedButton(
              color: Colors.lightBlueAccent,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackListScreen(),
                    ));
              },
              child: Text('View Data Mahasiswa'),
            ),
          ],
        ),
      ),
    );
  }
}
