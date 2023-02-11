import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:job_seeker/model/job.dart';
import 'package:job_seeker/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JobDetails extends StatefulWidget{
  final Map<String,dynamic> list;
  final String fromScreen;

  const JobDetails(
    {
      super.key,
      required this.list,
      required this.fromScreen
    }
  );

  @override
  State<StatefulWidget> createState() {
    return JobDetailsState(list,fromScreen,map_keys: []);
  }
}

class JobDetailsState extends State<JobDetails>{
  Map<String,dynamic> list;
  List<String> map_keys;
  String fromScreen;

  JobDetailsState(this.list,this.fromScreen,{required this.map_keys});

  @override
  void initState() {
    for(var key in list.keys){
      map_keys.add(key);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: ()=> Navigator.pop(context),
        ),
        title: Row(
          children: const <Widget>[
            Icon(Icons.info),
            SizedBox(width: 10,),
            Text("Info",),
          ]
        ),
        actions: fromScreen=="home"?[
          IconButton(
            onPressed: () async{
              var service = UserService();
              List<dynamic> temp = await service.readAJob(list['unique_Id']);
              if(temp.isNotEmpty){
                Fluttertoast.showToast(msg: 'Already saved');
              }
              else{
                await service.saveJob(list);
                Fluttertoast.showToast(msg: 'saved to favourites');
              }
            }, 
            icon: const Icon(Icons.download_for_offline, size: 30,)
          ),
          const SizedBox(width: 15,),
        ]:[],
      ),
      body: Container(
        padding: const EdgeInsets.only(top:40.0,left: 20.0,right: 20.0,bottom: 10.0),
        child: DetailTable(map_keys,list),
      ),
    );
  }
}

class DetailTable extends StatelessWidget{
  var leftColumnTextStyle = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  var rightColumnTextStyle = const TextStyle(fontSize: 20.0);
  
  List<String> keys;
  Map<String, dynamic> list;
  DetailTable(this.keys,this.list, {Key? key}) : super(key: key);

  List<TableRow> getTableRowList(keys,list){
    List<TableRow> rowList=[];
    for(var k in keys){
      if(k=="unique_Id"){continue;}
      if(list[k]==""){list[k]="unavailable";}
       rowList.add(
        TableRow(
        children: [
          TableCell(
            child: Text(k,style: leftColumnTextStyle,),
          ),
          TableCell(
            child: Text(list[k],style: rightColumnTextStyle,),
          )
        ]
       )
       );
       rowList.add(
        const TableRow(
          children: [
            TableCell(child: SizedBox(height: 20),),
            TableCell(child: SizedBox(height: 20),),
          ]
        )
       );
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context){
    return Table(
      children: getTableRowList(keys,list),
      // [
      //    TableRow(
      //   children: [
      //     TableCell(
      //       child: Text('company_Name',style: leftColumnTextStyle,),
      //     ),
      //     TableCell(
      //       child: Text('company_Name',style: rightColumnTextStyle,),
      //     )
      //   ]
      //  ),
      //  const TableRow(
      //   children: [
      //     TableCell(child: SizedBox(height: 20),),
      //     TableCell(child: SizedBox(height: 20),),
      //   ]
      //  )
      
      // ],
    );
  }
}