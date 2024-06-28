import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blank Sheets',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlankSheetsPage(),
    );
  }
}

class BlankSheetsPage extends StatefulWidget {
  @override
  _BlankSheetsPageState createState() => _BlankSheetsPageState();
}

class _BlankSheetsPageState extends State<BlankSheetsPage> {
  List<String> _sheets = [];
  TextEditingController _textEditingController = TextEditingController();

  void _addSheet() {
    setState(() {
      _sheets.add('');
    });
  }

  void _saveSheet(int index, String content) {
    setState(() {
      _sheets[index] = content;
    });
  }

  void _deleteSheet(int index) {
    setState(() {
      _sheets.removeAt(index);
    });
  }

  void _editSheet(int index) {
    _textEditingController.text = _sheets[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Sheet'),
          content: TextField(
            controller: _textEditingController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter your text here',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _saveSheet(index, _textEditingController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blank Sheets',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: TextButton(
              onPressed: _addSheet,
              child: Text(
                'New Sheet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _sheets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _sheets[index].isEmpty ? 'Empty Sheet' : _sheets[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _editSheet(index),
                  trailing: IconButton(
                    icon: Icon(Icons.clear, color: Colors.red),
                    onPressed: () => _deleteSheet(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
