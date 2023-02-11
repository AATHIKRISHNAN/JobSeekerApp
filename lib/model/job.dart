class Job{
  String? unique_Id;
  String? company_Name;
  String? job_Role;
  String? link;
  String? salary;
  String? qualification;
  String? batch;
  String? Experience;
  String? location;
  String? lastDate;

  jobMap(){
    var mapping = Map<String,dynamic>();
    mapping['company_Name'] = company_Name!;
    mapping['job_Role']     = job_Role!;
    mapping['unique_Id']    = unique_Id!;
    mapping['link']         = link??Null;
    mapping['salary']       = salary??Null;
    mapping['qualification']= qualification??Null;
    mapping['batch']        = batch??Null;
    mapping['Experience']   = Experience??Null;
    mapping['location']     = location??Null;
    mapping['lastDate']     = lastDate??Null;
    return mapping;
  }
}