class CurrentUser{
  static String email = "";
  static String firstName = "";
  static String lastName = "";
  static String funds = "";
  static String image = "";
  
  static String getInfo()
  {
    return "email=$email, firstName=$firstName, lastName=$lastName, funds=$funds, image=$image";
  }
}