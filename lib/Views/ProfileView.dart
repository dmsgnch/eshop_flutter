import 'package:eshop/Controllers/ProfileController.dart';
import 'package:eshop/Models/Domain/User.dart';
import 'package:eshop/Models/Enums/AccountType.dart';
import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:eshop/Views/DialogConfirmView.dart';
import 'package:eshop/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfileView extends StatefulWidget {
  final MyHomePageState myHomePageState;

  const ProfileView({Key? key, required this.myHomePageState})
      : super(key: key);

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileView> {
  final ProfileController profileController = ProfileController();
  late User user;

  void UpdateProducts() {
    setState(() {
      user = GetIt.instance.get<User>();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      user = GetIt.instance.get<User>();
    });

    profileController.SetUpdateFunction(UpdateProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 27, 31, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
        title: const Text('Profile', style: TextStyle(color: Colors.grey)),
        actions: [
          IconButton(
            icon: const Icon(Icons.update, color: Colors.grey),
            onPressed: UpdateProducts,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        color: const Color.fromRGBO(30, 30, 30, 1),
        child: Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              DialogConfirmView dialogConfirmView = DialogConfirmView();
              dialogConfirmView.ShowUserDialog(
                  context,
                  Message(
                      MessageType.Warning, "Are you sure you want to log out?"),
                  profileController.NavigateToLoginScreen);
            },
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.white70, fontSize: 22),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Name: ${user.name}",
                  style: const TextStyle(color: Colors.white70, fontSize: 20)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Email: ${user.email}",
                  style: const TextStyle(color: Colors.white70, fontSize: 20)),
            ),
            if (GetIt.instance.get<User>().accountType == AccountType.Manager)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Account type: ${GetAccountTypeName.getAccountTypeName(user.accountType)}",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 20)),
              ),
          ],
        ),
      ),
    );
  }
}
