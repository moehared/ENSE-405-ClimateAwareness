import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add post'),
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(labelText: 'description'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
