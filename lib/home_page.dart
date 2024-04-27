import 'dart:convert';

import 'package:api_integration_first_project/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<GetModel> getList = [];

 Future<List<GetModel>> getApimodel()async{

  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

  var data = jsonDecode(response.body.toString());

  if(response.statusCode == 200){
  for(Map<String,dynamic> i in data){
    getList.add(GetModel.fromJson(i));
  }
  return getList;
  }else{
    return getList;
  }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Integration"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApimodel(), 
              builder: (BuildContext context, AsyncSnapshot<List<GetModel>> snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: Text("Loading...."),
                  );
                }else{
                 return ListView.builder(
                  itemCount: getList.length,
                  itemBuilder: (context,index){
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(getList[index].id.toString()),
                                SizedBox(width: 5,),
                                Text(getList[index].title.toString(),style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                          Text(getList[index].body.toString()),
                          SizedBox(width: 20,),
                        ],
                      )
                    ],
                  );
                 });
                }
              },
              
              ),
          )
        ],
      ),
    );
  }
}