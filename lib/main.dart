import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //para hacer peticiones
import 'dart:async'; // para trabajar asyncrono
import 'dart:convert'; // para convetir a json

void main() {
  // Funcion principal que necesita DART

  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  // Estado?
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List data;
  late List movementsData;

  getMovements() async {
    http.Response response = await http
        .get(Uri.parse('https://api-whaling.herokuapp.com/movements'));
    data = json.decode(response.body); //convertilos a json

    setState(() {
      movementsData = data;
    });
  }

  @override
  void initState() {
    //Apenas inicia la app...
    super.initState();

    getMovements();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
          itemCount: movementsData == null ? 0 : movementsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://logos.covalenthq.com/tokens/56/${movementsData[index]['token']['contract']}.png'),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
