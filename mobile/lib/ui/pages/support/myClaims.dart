import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/service/claims.dart';

// ignore: must_be_immutable
class MyClaims extends StatefulWidget {
  User user;
  MyClaims(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<MyClaims> createState() => _MyClaims(this.user);
}

class _MyClaims extends State<MyClaims> {
  User user;
  // late Future<List<Claim>> claims;

  _MyClaims(this.user);
  @override
  void initState() {
    super.initState();
    fetchClaims();
    // claims = ClaimsService().getMyClaims();

    // print(claims);
  }

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('My Claims'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
            child: Center(
                child: FutureBuilder(
              future: ClaimsService().getMyClaims(),
              builder: ((context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  // return Text(snapshot.data!.title);
                  return getOneClaim(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }),
            )),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }

  void fetchClaims() async {
    Future<List<Claim>> myclaims = ClaimsService().getMyClaims();
  }
}

class getOneClaim extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  // Product product;
  // listView(this.product);
  late List<Claim> claims;
  getOneClaim(this.claims);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
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
                  subtitle:
                      Text('14-12-2022', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  // @override
  // Widget build(List<Product> claims) => ListView.builder(
  //   itemCount: products.length,
  //   itemBuilder: ((context, index) => {
  //     final product = products[index];
  //     return Card(
  //       child: ListTile(
  //         title: Text(product.title),
  //         subtitle: Text(product.description),
  //       )
  //     )})
  //     );

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.separated(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: entries.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         height: 50,
  //         color: Colors.amber[colorCodes[index]],
  //         child: Center(child: Text('${product.description}')),
  //       );
  //     },
  //     separatorBuilder: (BuildContext context, int index) => const Divider(),
  //   );
  // }
}
