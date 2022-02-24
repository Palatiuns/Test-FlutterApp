import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Estacionamento'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Entrada'),
    Tab(text: 'Saida'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),

        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.blue,
          width: 400,
          height: 400,

          child: TabBarView(
                controller: _tabController,
                children: myTabs.map((Tab tab) {
                  return Center(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                              width: 390,
                              height: 390,
                              color: Colors.grey,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  <Widget>[
                                      Row(
                                        children: const <Widget>[
                                          Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                                            child:  Text("Numero da placa:", style: TextStyle(fontSize: 27),),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: TextFormField (
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                              },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              fillColor: Colors.white70,
                                              filled: true,
                                              hintText: 'AAA-0000',
                                            )
                                        ),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      Container(
                                        width: 380,
                                        child: ElevatedButton (
                                          onPressed: (){
                                            if (_formKey.currentState!.validate()) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Processing Data')),
                                              );
                                            }
                                            },
                                          child: const Text("confirmar entrada"),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                          ),
                        ),
                      ],
                    ),
                  );

                }).toList(),
              ),

        ),
      )



    );
  }
}
