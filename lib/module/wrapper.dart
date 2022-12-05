import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescue_pet/layout/mainLayout.dart';
import 'package:rescue_pet/model/User/User.dart';
import 'package:rescue_pet/module/authenticate/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    print(user);

    //check if authenticated or not
    return user!= null? MainLayout(): SignIn();
  }
}
