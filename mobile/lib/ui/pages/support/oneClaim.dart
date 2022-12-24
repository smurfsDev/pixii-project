import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';

class getOneClaim extends StatelessWidget {
  late List<Claim> claims;
  getOneClaim(this.claims);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: claims.length,
      itemBuilder: (BuildContext context, int index) {
        final claim = claims[index];
        return Center(
          child: Card(
            color: Color.fromARGB(255, 29, 39, 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 50,
                  ),
                  title: Text(
                    "${claim.title}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text('${claim.created}',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
      // separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
