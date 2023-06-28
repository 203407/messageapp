import 'package:flutter/material.dart';
import 'package:messageapp/features/message/chat/presentation/pages/showmessages2.dart';

class ShowContactos extends StatelessWidget {
  const ShowContactos(
      {Key? key,
      required this.username,
      required this.currentUser,
      required this.correother,
      required this.correousuario})
      : super(key: key);

  final String? username;
  final String? currentUser;
  final String? correother;
  final String? correousuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/images/profile_image.png'),
      title: Text(
        username!,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(correother!),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignF3(
                    username: username,
                    currentUser: currentUser,
                    correousuario: correother,
                  )),
        );
        // print("pagina pa ir a chat");
      },
    );
  }
}
