import 'package:actividad1/features/games/presentation/pages/signF.dart';

import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(208, 0, 0, 0),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(),
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportContrains) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Text("GameReview",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: (CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/games.jpg'))),
                    ),
                  ),
                  ElevatedButton(
                    /*Google*/
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 23, 151, 255),
                      onPrimary: const Color.fromARGB(255, 254, 253, 253),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        // MaterialPageRoute(builder: (context) => Sign(user: user)),
                        MaterialPageRoute(builder: (context) => const SignF()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 8),
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 253, 253),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            }),
          ),
        ));
  }
}
