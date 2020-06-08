import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  String nome = "";
  String email = "";
  String msg = "";

  _gravar() async {
    final pref = awaitSharedPreferences.getInstance();
    nome = _controllerNome.text;
    email = _controllerEmail.text;
    pref.setString("nome", nome);
    pref.setString("email", email);
    setState(() {
      msg = "ok!";
      _controllerNome.text = "";
      _controllerEmail.text = "";
    });
  }

  _ler() async {
    final pref = awaitSharedPreferences.getInstance();
    String nome = pref.getString("nome");
    String email = pref.getString("email");
    setState(() {
      _controllerNome.text = nome;
      _controllerEmail.text = email;
    });
  }

  _limpar() async {
    final pref = awaitSharedPreferences.getInstance();
    pref.remove("nome");
    pref.remove("email");
    setState(() {
      msg = "ok!!!";
      _controllerNome.text = "";
      _controllerEmail.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreferences"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text(
              msg,
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "seu nome"),
              controller: _controllerNome,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "seu email"),
              controller: _controllerEmail,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Gravar", style: TextStyle(fontSize: 20)),
                  onPressed: _gravar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Ler", style: TextStyle(fontSize: 20)),
                  onPressed: _ler,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Limpar", style: TextStyle(fontSize: 20)),
                  onPressed: _limpar,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
