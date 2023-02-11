import 'package:job_seeker/db_helper/repository.dart';
import 'package:job_seeker/model/job.dart';

class UserService{
  late Repository _repository;
  String table_name = 'favourite_jobs';
  UserService(){
    _repository = Repository();
  }

  saveJob(Map<String,dynamic> job) async{
    return await _repository.insertData(table_name, job);
  }

  readAllJobs() async{
    return await _repository.readData(table_name);
  }

  deleteAJob(String itemId) async{
    return await _repository.deleteDataById(table_name, itemId);
  }

  readAJob(String itemId) async{
    return await _repository.readDataById(table_name, itemId);
  }

  // isSaved(String itemId) async{
  //   print(await _repository.readDataById(table_name, itemId));
  //   List<dynamic> temp =await _repository.readDataById(table_name, itemId);
  //   if(temp.length==0){
  //     print("did not save");
  //   }
  //   else{
  //     print("saved");
  //   }
  // }
}