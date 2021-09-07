import 'package:kingpinssdp/current_user.dart';
import 'package:test/test.dart';

void main(){
   test('current user details should be empty ...', () {
      String details = CurrentUser.getInfo();
      expect(details, "email=, firstName=, lastName=, funds=, image=");
    });

    test('current user details should reflect changes made to static variables ...', () {

      CurrentUser.email = "email";
      CurrentUser.firstName = "firstname";
      CurrentUser.lastName = "lastname";
      CurrentUser.funds = "funds";
      CurrentUser.image = "image";

      String details = CurrentUser.getInfo();
      expect(details, "email=email, firstName=firstname, lastName=lastname, funds=funds, image=image");
    });
}