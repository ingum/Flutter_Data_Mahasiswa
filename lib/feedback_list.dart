import 'dart:js';

import 'package:flutter/material.dart';

import 'controller/form_controller.dart';
import 'model/form.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feedback Responses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedbackListPage(title: "List Mahasiswa"));
  }
}

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>();

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0 ),
            child: Card(
             child: ListTile(
              trailing: Icon(Icons.checklist),
              title: Text(feedbackItems[index].name),
              subtitle: Text(feedbackItems[index].email),
              leading: CircleAvatar(),
              onTap: () {

                Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DetailPage(feedbackItems[index]))
                );
              },

            ),
            ),
          );
        }
      ),
    );
  }
}

class DetailPage  extends StatelessWidget {

  final FeedbackForm user;
  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        ),
    );
  }
}