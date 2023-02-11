import 'package:flutter/material.dart';
import 'package:job_seeker/model/job.dart';
import 'package:job_seeker/services/user_services.dart';
import 'package:job_seeker/app_screens/job_detail.dart';

class Favourites extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavouritesState();
  }
}

class FavouritesState extends State<Favourites>{
  // int count = 10;
  List<Map<String,dynamic>> _jobList=<Map<String,dynamic>>[];
  final _service = UserService();

  getAllJobDetails() async{
    var temp = await _service.readAllJobs();
    setState(() {
      _jobList = temp;
    });
  }

  @override
  void initState() {
    getAllJobDetails();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<dynamic>(
        future: _service.readAllJobs(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            print("Error in loading "+snapshot.error.toString());
          }
          return snapshot.hasData?getFovouritesList():const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView getFovouritesList(){

    return ListView.builder(
      itemCount: _jobList.length,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(_jobList[position]['job_Role'], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            subtitle: Text(_jobList[position]['company_Name'],style: const TextStyle(fontSize: 15),),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (ctx) => AlertDialog(
                    title: Text('Alert'),
                    content: Text('Are you sure you want to delete?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () async{
                          await _service.deleteAJob(_jobList[position]['unique_Id']);
                          setState(() {
                            getAllJobDetails();
                          });
                          Navigator.of(ctx).pop();
                        }, 
                        child: Text('OK')
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.of(ctx).pop();
                        }, 
                        child: Text('cancel')
                      )
                    ],
                  )
                );
              },
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  JobDetails(
                list:_jobList[position], fromScreen: "favourite"
              )));
            },
          ), 
        );
      },
    );
  }
}
