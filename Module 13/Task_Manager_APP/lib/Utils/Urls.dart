class urls{
  static String baseURL="https://task-manager-api.ostad.live/api/v1";
  static String signUPURL = "$baseURL/Registration";
  static String signInURL = "$baseURL/Login";
  static String getTaskCountURL = '$baseURL/taskStatusCount';
  static String  CreateTaskURL = '$baseURL/createTask';
  static String  updateProfileURL = '$baseURL/ProfileUpdate';
  static String getTaskByStatusURL(String status) => '$baseURL/listTaskByStatus/$status';
  static String deleteTaskURL(String id) => '$baseURL/deleteTask/$id';
  static String updateTaskStatusURL(String id,String Status) => '$baseURL/updateTaskStatus/$id/$Status';


}