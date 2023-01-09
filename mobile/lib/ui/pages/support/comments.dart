import 'package:flutter/scheduler.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Comment.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/oneComment.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Comments extends StatefulWidget {
  User user;
  Claim claim;

  Comments(this.claim, this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Comments> createState() => _Comments(this.claim, this.user);
}

class _Comments extends State<Comments> {
  // late List<Claim> claims;
  User user;
  Claim claim;
  final _formKey = GlobalKey<FormState>();
  String message = "";

  Color colorClaim = Colors.red;

  _Comments(this.claim, this.user);

  List<Comment>? commentsTable;
  List<Comment> allComments = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final cs = Provider.of<ClaimsService>(context);
//     cs.getClaim(claim.id).then((value) {
//       setState(() {
//         allComments.clear();
//       });
//       value!.comments!.forEach((element) {
//         setState(() {
//           allComments.add(
//             Comment(
//               claim: claim.id,
//               id: element['_id'],
//               created: element['created'],
//               message: element['message'],
//               user: element['user']['name'],
//             ),
//           );
//         });
//       });
//     });
// //  _scrollController.animateTo(
// //               _scrollController.position.maxScrollExtent,
// //               duration: const Duration(milliseconds: 1),
// //               curve: Curves.fastOutSlowIn,
// //             );
//     });
  }

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    claimsService.getClaim(claim.id).then((value) {
      allComments.clear();
      value?.comments.forEach((element) {
        allComments.add(
          Comment(
            claim: claim.id,
            id: element['_id'],
            created: element['created'],
            message: element['message'],
            user: element['user']['name'],
          ),
        );
      });
    });

    addComment(ClaimsService claimsService) async {
      if (_formKey.currentState!.validate()) {
        final commentCreated =
            await claimsService.createComment(this.claim.id, message);

        if (commentCreated) {
          Claim? commentClaim;
          try {
            commentClaim = await claimsService.getClaim(claim.id);
          } catch (e) {}
          setState(() {
            message = "";
            allComments.clear();
            commentClaim?.comments.forEach((element) {
              print(element['message']);
              allComments.add(
                Comment(
                  claim: claim.id,
                  id: element['_id'],
                  created: element['created'],
                  message: element['message'],
                  user: element['user']['name'],
                ),
              );
            });
          });
          _formKey.currentState?.reset();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          });
          // toast
          Fluttertoast.showToast(
              msg: "Comment added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          showAlert(context, 'Error', claimsService.createClaimError);
        }
      }
    }

    Widget comments_component() {
      return Flexible(
        child: ClipRRect(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: allComments.length,
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (BuildContext context, int index) {
              final comment = allComments[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OneComment(user!, comment))),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: const BoxDecoration(
                    color: const Color.fromARGB(255, 29, 39, 70),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.amber,
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${comment.user}  ",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${comment.created!.substring(0, 10)}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  comment.message,
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    Widget buildInput() {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onChanged: (value) => {
                      setState(
                        () {
                          message = value;
                        },
                      )
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("please enter a comment");
                      }
                      return null;
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type your comment...',
                    ),
                    autofocus: true,
                  ),
                ),
              ),
            ),

            // Button send message
            Material(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => {
                    addComment(claimsService),
                  },
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 0.5)), color: Colors.white),
      );
    }

    if (allComments.isEmpty) {
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.lightBlue,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "There are no comments yet",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "You can add a comment below",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                buildInput(),
              ],
            ),
          ],
        ),
      );
    }

    return SafeArea(
        child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // List of messages
            comments_component(),

            // Input content
            buildInput(),
          ],
        ),
      ],
    ));
  }
}
