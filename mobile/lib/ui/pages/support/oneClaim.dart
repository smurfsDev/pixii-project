import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';

class getOneClaim extends StatefulWidget {
  List<Claim> claim;
  getOneClaim(this.claim, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<getOneClaim> createState() => _getOneClaim(this.claim);
}

class _getOneClaim extends State<getOneClaim> {
  late List<Claim> claims;
  Color colorClaim = Colors.red;

  _getOneClaim(this.claims);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: claims.length,
      itemBuilder: (BuildContext context, int index) {
        final claim = claims[index];

        final statusClaim = Status.fromJson(claim.status);
        if (statusClaim.name == "TODO") {
          colorClaim = Colors.red.shade800;
        }
        if (statusClaim.name == "INPROGRESS") {
          colorClaim = Colors.orange.shade600;
        }
        if (statusClaim.name == "DONE") {
          colorClaim = Colors.green;
        }
        if (statusClaim.name == "STUCK") {
          colorClaim = Colors.blue.shade800;
        }

        return Center(
          child: Card(
            color: Color.fromARGB(255, 29, 39, 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: colorClaim,
                    size: 50,
                  ),
                  title: Text(
                    "${claim.title}  ",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text('${claim.created}',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
