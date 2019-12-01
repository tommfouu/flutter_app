import 'dart:convert';
import 'package:flutter/material.dart';
import 'env.dart';
import 'activity.dart';
import 'detailsActivite.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/icon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("myapp"),
        ),
        body: Page1(),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  Screen createState() => Screen();
}

Future<Reponses> fetchPost(final String lieu,final String act) async {
  String url='https://api.foursquare.com/v2/venues/search?near=${lieu}&query=${act}&client_id=${clientId}&client_secret=${secret_client}&v=20180323';
  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print('code 200');
    print("res: "+ ""+Reponses.fromJson(json.decode(response.body)).toString());

    return Reponses.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load activities');
  }
}

class Reponses {
  final List<ItemReponse> listeReponses;

  Reponses({this.listeReponses});

  factory Reponses.fromJson(Map<String, dynamic> json) {
    List<ItemReponse> tes = new List<ItemReponse>();
    for (var items in json["response"]["venues"]) {
      print("ici: "+items.toString());
      ItemReponse itemReponse = new ItemReponse(items["id"], items["name"]);
      itemReponse.setLatitude(items["location"]["lat"].toString());
      itemReponse.setLongitude(items["location"]["lng"].toString());
      itemReponse.setAddress(items["location"]["address"].toString());
      if (items["categories"] == []) {
        var obj = items["categories"][0]["icon"];
        itemReponse.setIcon(obj["prefix"].toString()+""+obj["suffix"].toString());
      }
      tes.add(itemReponse);
    }
    return Reponses(listeReponses: tes);
  }
}

class ItemReponse {
  String id;
  String name;
  String description;
  List<String> photos = new List();
  List<String> comments = new List();
  String commentsBis;
  String latitude;
  String longitude;
  String address;
  String city;
  String region;
  String country;
  String cat;
  String url_icon;
  String phone;

  @override
  String toString() {
    return 'ItemReponse{id: $id, name: $name, description: $description, photos: $photos, comments: $comments, commentsBis: $commentsBis, latitude: $latitude, longitude: $longitude, city: $city, region: $region, country: $country, cat: $cat}';
  }

  ItemReponse(String id, String name){
    this.id= id;
    this.name= name;
  }

  ItemReponse.toString(){
    print("id : "+this.id + ", name : "+this.name);
  }

  setDescription(String desc){
    this.description = desc;
  }

  setIcon(String url){
    this.url_icon = url;
  }

  setAddress(String add){
    this.address = add;
  }

  setComments(List<String> comm){
    this.comments = comm;
  }
  setPhotos(List<String> ph){
    this.photos = ph;
  }
  setLatitude(String lat){
    this.latitude = lat;
  }
  setLongitude(String long){
    this.longitude = long;
  }

}


List<String> getSuggestions(){
  return new List<String>(0);
}

void setSuggestions(){

}

class ReponsesDetails {
  ItemReponse itemReponse;

  ReponsesDetails({this.itemReponse});

  factory ReponsesDetails.fromJson(Map<String, dynamic> json) {
    ItemReponse itemR = new ItemReponse(json["response"]["venue"]["id"], json["response"]["venue"]["name"]);
    if(json["response"]["venue"]["contact"]["formattedPhone"] != null){
      itemR.phone = (json["response"]["venue"]["contact"]["formattedPhone"]);
    }else{
      itemR.description = null;
    }
    itemR.setLatitude(json["response"]["venue"]["location"]["lat"].toString());
    itemR.setLongitude(json["response"]["venue"]["location"]["lng"].toString());
    if(json["response"]["venue"]["description"] != null){
      itemR.setDescription(json["response"]["venue"]["description"]);
    }else{
      itemR.description = null;
    }
    if(json["response"]["venue"]["tips"]["groups"][0]["items"].toString().length > 2){
      itemR.commentsBis = (json["response"]["venue"]["tips"]["groups"][0]["items"][0]["text"]);
    } else {
      itemR.commentsBis = null;
    }
    if(json["response"]["venue"]["bestPhoto"] != null){
      itemR.photos.add(
          json["response"]["venue"]["bestPhoto"]["prefix"]+
              json["response"]["venue"]["bestPhoto"]["width"].toString()+
              "x"+
              json["response"]["venue"]["bestPhoto"]["height"].toString()+
              json["response"]["venue"]["bestPhoto"]["suffix"]

      );
    }else{
      itemR.photos.add(
          "https://www.prendsmaplace.fr/wp-content/themes/prendsmaplace/images/defaut_image.gif"
      );
    }
    if(json["response"]["venue"]["categories"].toString().length > 2) {
      itemR.cat = json["response"]["venue"]["categories"][0]["name"];
    }else{
      itemR.cat = null;
    }

    return ReponsesDetails(itemReponse: itemR);
  }
}

Future<ReponsesDetails> fetchPostDetails(final ItemReponse itemrep) async {
  String url='https://api.foursquare.com/v2/venues/${itemrep.id}?client_id=${clientId}&client_secret=${secret_client}&v=20180323';
  print("url: "+url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print('code 200');
    print("res: "+ ""+ReponsesDetails.fromJson(json.decode(response.body)).toString());

    return ReponsesDetails.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load activities');
  }
}

class Screen extends State<Page1> {
  final _formKey = GlobalKey<FormState>();
  final List<ItemReponse> _suggestions = <ItemReponse>[];
  final Set<String> _saved = Set<String>();
  final myControllerPlace = TextEditingController();
  final myControllerActivity = TextEditingController();

  @override
  void dispose() {
    myControllerPlace.dispose();
    myControllerActivity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children:<Widget>[
          TextField(
            controller: myControllerPlace,
            decoration: InputDecoration(
                hintText: 'Lieu'
            ),
          ),
          TextField(
            controller: myControllerActivity,
            decoration: InputDecoration(
                hintText: 'Rechercher'
            ),
          ),
          FlatButton.icon(
            color: Colors.grey,
            icon: Icon(Icons.search), //`Icon` to display
            label: Text('Lancer la recherche'), //`Text` to display
            onPressed: () {

              fetchPost(myControllerPlace.text, myControllerActivity.text).then((result) {
                _suggestions.clear();
                setState(() {
                  _suggestions.addAll(result.listeReponses);
                });
              });
            },
          ),
        Expanded(
            child:SizedBox(
              height: 200.0,
              child: new ListView.builder(

                  itemCount: _suggestions.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child : Container(
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        //color: Colors.amber[500],
                        child: (Text( _suggestions[index].name)),
                      ),
                      onTap: () => {
                        fetchPostDetails(_suggestions[index]).then((result){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ActiviteDetails(result.itemReponse)));
                        }),
                      }
                    );
                  }
              ),
            )

        ),
        //MyList(data)
      ]
    );
  }




}


