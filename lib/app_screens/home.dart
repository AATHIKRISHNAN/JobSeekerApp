import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_seeker/app_screens/job_detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return JobListState();
  }
}

Future<List> getData_jobs() async{
  var url = Uri.http('jobseekerminiproject.000webhostapp.com', 'api/job_seeker/getData_JOB.php');
  final response = await http.get(url);
  var dataReceived = jsonDecode(response.body);
  //print(dataReceived);
  return dataReceived;
}

class JobListState extends State<Home>{

  @override
  void initState() {
    getData_jobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List>(
        future: getData_jobs(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            print("Error in loading "+snapshot.error.toString());
          }
          return snapshot.hasData?getJobListView(list:snapshot.data):const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView getJobListView({List? list}){

    return ListView.builder(
      itemCount: list==null?0:list.length,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(list![position]['job_Role'], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            subtitle: Text(list[position]['company_Name'],style: const TextStyle(fontSize: 15),),
            onTap: (){
              //  print(list[position]);
              
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  JobDetails(
                list:list[position] as Map<String,dynamic>, fromScreen:"home"
              )));
            },
          ), 
        );
      },
    );
  }
}