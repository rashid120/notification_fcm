/*
class One{

  show(){
    print('Class One');
  }
}
class Two extends One{

  show(){

    print('Class Two');
    super.show();
  }
}

class Three extends Two{

  show(){
    print('Class Three');
    super.show();
  }
}
*/

/*
class One{

  int num = 30;
}

class Two extends One{

  int num = 70;

  int sum(){

    print(num);
    var m = num;
    return m;
  }
}
class Three extends Two{

  int num = 30;

}


void main(){

*/
/*
  var obj = Three();
  obj.show();

  */
/*


  var obj2 = Three();

  print(obj2.sum());

}
*/


import 'dart:io';
import 'dart:math';

void main(){

  var accountObj = Bank(name: "Rashid", email: "rashid@gmail.com", password: "rashid123", adharCard: "324567899876", penCard: "A344DF34D");

   accountObj.bankDetails();
   accountObj.updateBalance = 100;
  accountObj.checkBalance();
    accountObj.checkBalance();
    accountObj.checkBalance();
}


class Bank{

  Bank({
    required this.name,
    required this.email,
    required this.password,
    required this.adharCard,
    required this.penCard,
  });

  String name;
  final String email;
  String password;
  final String adharCard;
  final String penCard;

  final _accountNumber = Random().nextInt(1999999999);
  var _balance = Random().nextInt(4);

  // setter
  set updateBalance(int newBalance) => _balance += newBalance;
  set updateName(String newName) => name = newName;
  set updatePassword(String newPass) => password = newPass;

  void bankDetails(){

    print("Name : $name");
    print("Account No : $_accountNumber");
    print("Email : $email");
    print("Aadhar Card : $adharCard");
    print("Pen Card : $penCard");
    print("Password : $password");
  }

  void checkBalance(){

    print("");
    stdout.write("Enter your password : ");
    var enterPass = stdin.readLineSync().toString();
    print("");

    if(enterPass == password){
      print("Name : $name");
      print("Account No : $_accountNumber");
      print("Total balance : $_balance");
    }else{

      print("Your entered wrong password");
    }
  }

  void deposit({required String name, required String account, required int amount, required String password}){

  }
}