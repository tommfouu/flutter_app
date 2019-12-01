import 'dart:convert';
import 'package:flutter/material.dart';
import 'env.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//void main() => runApp(ActiviteDetails());


class ActiviteDetails extends StatelessWidget {

  ItemReponse item;

  ActiviteDetails(ItemReponse item){
    this.item = item;
  }

  //ActiviteDetails({Key key, @required this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: PageDetails(this.item),
      ),
    );
  }

}

class PageDetails extends StatefulWidget {

  ItemReponse i;

  PageDetails(ItemReponse i){
    this.i = i;
  }

  @override
  Screen createState() => Screen(this.i);
}

class Screen extends State<PageDetails> {

  final _formKey = GlobalKey<FormState>();
  ItemReponse i;

  Screen(ItemReponse i){
    this.i = i;
    print("screen i: "+ i.toString());
    print("size photos "+ i.photos.length.toString());
  }

  Widget equalNull(BuildContext context, Object obj, String text) {
    if(Object != null){
      return Text(text+" : "+obj);
    }else{
      return Text(text+" : Non référencée !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(         // Add 6 lines from here...
        appBar: AppBar(
          title: Text(i.name),
        ),
      body: Center(

        child: Column(
          children: <Widget>[
            Text(
              i.name??'Aucun Titre',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //equalNull(context, i.cat, "Categorie"),
            Text(i.phone??'Pas de numéro de téléphone'),
            Text(i.description??'Description : Non référencée !'),
            Image.network(
                i.photos[0],height: 500.0,
              width: 350.0,
            ),
            Text(
              'Commentaire :',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
                i.commentsBis??'Aucune Commentaires !'
            ),
            //Padding(
              //padding: const EdgeInsets.symmetric(vertical: 16.0),
                FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () => {
                      print('https://www.google.fr/maps/search/'+i.latitude+','+i.longitude),
                      launch('https://www.google.fr/maps/search/'+i.latitude+','+i.longitude)
                    },
                  child: Text('Open in GoogleMap'),
                ),
            //),
          ],

        ),

      ),
    );
  }
}
/*
void newScreen(){
  Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context){
            return Scaffold(         // Add 6 lines from here...
                appBar: AppBar(
                  title: Text('nom de l\'item'),
                ),
                body: Column(
                  children: <Widget>[
                    Text('adresse'),
                    Text('description'),
                    Image(
                      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                    Expanded(
                        child: ListView(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo_album),
                                title: Text('Album'),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text('Phone'),
                              ),
                            ]
                        )
                    )
                  ],
                )
            );
          }
      )
  );
}*/
