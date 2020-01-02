import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './model/joke_model.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Jokes!'),
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
  int id = 0;
  String setup;
  String punchline;
  List isSelected;

  void _incrementCounter()  async{

    var url = "https://official-joke-api.appspot.com/random_joke";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      JokeModel jokeModel = JokeModel(jsonResponse['id'],jsonResponse['setup'],jsonResponse['punchline']);
      setState(() {
        setup=jokeModel.setup;
        punchline=jokeModel.punchline;
        id=jokeModel.id;


      });

    } else {
      setup="Sorry! can't find more jokes. ";
      print("Request failed with status: ${response.statusCode}.");
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          margin: EdgeInsets.all(40.00),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.body1.copyWith(fontSize: 40),
                      children: [
                        TextSpan(
                          text: '$setup ',
                        ),
                        TextSpan(
                            text: '$punchline',
                            style: TextStyle(
                                color: Colors.blue
                            )
                        )
                      ]
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                ],
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
