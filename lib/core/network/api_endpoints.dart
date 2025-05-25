class ApiEndPoint {
  ApiEndPoint._();
  static String baseurl = 'https://6832af4bc3f2222a8cb314bd.mockapi.io/';
  static String login = '$baseurl/login';
  static String loginUser(String id) => '$baseurl/login/$id';
  static String allVehicles = '$baseurl/vehicles';
  static String VehicleDetails(String id) => '$baseurl/vehicles/$id';


}