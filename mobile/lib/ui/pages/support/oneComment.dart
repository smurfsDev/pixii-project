// import 'dart:html';

import 'package:mobile/imports.dart';
import 'package:mobile/models/Comment.dart';
import 'package:mobile/service/claims.dart';

// ignore: must_be_immutable
class OneComment extends StatefulWidget {
  User user;
  Comment comment;
  OneComment(this.user, this.comment, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<OneComment> createState() => _OneComment(this.user, this.comment);
}

class _OneComment extends State<OneComment> {
  Comment comment;
  User user;

  _OneComment(this.user, this.comment);

  @override
  Widget build(BuildContext context) {
    // final claimsService = Provider.of<ClaimsService>(context);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(comment.user),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(35),
                      child: Center(
                        child: ListTile(
                          leading: Image.asset('assets/images/avatar.jpg'),
                          title: Text(comment.user),
                          subtitle: Text(
                            "${comment.created.substring(11, 16)} on ${comment.created.substring(0, 10)} ",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: Text(
                      '${comment.message}',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     ElevatedButton(
                  //       // textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                  // Image.asset('assets/images/avatar.jpg'),
                  // Image.asset('assets/images/avatar.jpg'),
                ],
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }
}
