import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Comment.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/claimsTabs.dart';
import 'package:mobile/ui/pages/support/oneComment.dart';
import 'package:mobile/ui/pages/support/support.dart';

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

  Color colorClaim = Colors.red;

  _Comments(this.claim, this.user);

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);

    List<Comment>? commentsTable;
    List<Comment> allComments = [];
    for (var element in claim.comments) {
      Comment comment =
          Comment(id: '', message: '', user: '', claim: '', created: '');

      final commentClaim = Comment.fromJson(element);

      if (commentClaim.claim == claim.id) {
        comment.id = commentClaim.id;
        comment.message = commentClaim.message;
        comment.user = commentClaim.user;
        comment.created = commentClaim.created;
        comment.claim = commentClaim.claim;
        allComments.add(comment);
      }
    }
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 22, 30, 53),
        ),
        child: ClipRRect(
          child: ListView.builder(
            itemCount: allComments.length,
            itemBuilder: (BuildContext context, int index) {
              final comment = allComments[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OneComment(user, comment))),
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      ),
    );
  }
}
