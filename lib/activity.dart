// To parse this JSON data, do
//
//     final activityRes = activityResFromJson(jsonString);

import 'dart:convert';

class Geocode {
  String what;
  String where;
  Center center;
  String displayString;
  Cc cc;
  Geometry geometry;
  String slug;
  String longId;

  Geocode({
    this.what,
    this.where,
    this.center,
    this.displayString,
    this.cc,
    this.geometry,
    this.slug,
    this.longId,
  });

  factory Geocode.fromJson(Map<String, dynamic> json) => Geocode(
    what: json["what"],
    where: json["where"],
    center: Center.fromJson(json["center"]),
    displayString: json["displayString"],
    cc: ccValues.map[json["cc"]],
    geometry: Geometry.fromJson(json["geometry"]),
    slug: json["slug"],
    longId: json["longId"],
  );

  Map<String, dynamic> toJson() => {
    "what": what,
    "where": where,
    "center": center.toJson(),
    "displayString": displayString,
    "cc": ccValues.reverse[cc],
    "geometry": geometry.toJson(),
    "slug": slug,
    "longId": longId,
  };
}

enum Cc { FR }

final ccValues = EnumValues({
  "FR": Cc.FR
});

class Center {
  double lat;
  double lng;

  Center({
    this.lat,
    this.lng,
  });

  factory Center.fromJson(Map<String, dynamic> json) => Center(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Geometry {
  Bounds bounds;

  Geometry({
    this.bounds,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    bounds: Bounds.fromJson(json["bounds"]),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds.toJson(),
  };
}

class Bounds {
  Center ne;
  Center sw;

  Bounds({
    this.ne,
    this.sw,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    ne: Center.fromJson(json["ne"]),
    sw: Center.fromJson(json["sw"]),
  );

  Map<String, dynamic> toJson() => {
    "ne": ne.toJson(),
    "sw": sw.toJson(),
  };
}


class Reasons {
  int count;
  List<ReasonsItem> items;

  Reasons({
    this.count,
    this.items,
  });

  factory Reasons.fromJson(Map<String, dynamic> json) => Reasons(
    count: json["count"],
    items: List<ReasonsItem>.from(json["items"].map((x) => ReasonsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ReasonsItem {
  ItemSummary summary;
  Type type;
  ReasonName reasonName;

  ReasonsItem({
    this.summary,
    this.type,
    this.reasonName,
  });

  factory ReasonsItem.fromJson(Map<String, dynamic> json) => ReasonsItem(
    summary: itemSummaryValues.map[json["summary"]],
    type: typeValues.map[json["type"]],
    reasonName: reasonNameValues.map[json["reasonName"]],
  );

  Map<String, dynamic> toJson() => {
    "summary": itemSummaryValues.reverse[summary],
    "type": typeValues.reverse[type],
    "reasonName": reasonNameValues.reverse[reasonName],
  };
}

enum ReasonName { GLOBAL_INTERACTION_REASON }

final reasonNameValues = EnumValues({
  "globalInteractionReason": ReasonName.GLOBAL_INTERACTION_REASON
});

enum ItemSummary { CE_SITE_EST_POPULAIRE }

final itemSummaryValues = EnumValues({
  "Ce site est populaire": ItemSummary.CE_SITE_EST_POPULAIRE
});

enum Type { GENERAL }

final typeValues = EnumValues({
  "general": Type.GENERAL
});

class BeenHere {
  int count;
  int lastCheckinExpiredAt;
  bool marked;
  int unconfirmedCount;

  BeenHere({
    this.count,
    this.lastCheckinExpiredAt,
    this.marked,
    this.unconfirmedCount,
  });

  factory BeenHere.fromJson(Map<String, dynamic> json) => BeenHere(
    count: json["count"],
    lastCheckinExpiredAt: json["lastCheckinExpiredAt"],
    marked: json["marked"],
    unconfirmedCount: json["unconfirmedCount"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "lastCheckinExpiredAt": lastCheckinExpiredAt,
    "marked": marked,
    "unconfirmedCount": unconfirmedCount,
  };
}

enum Suffix { PNG }

final suffixValues = EnumValues({
  ".png": Suffix.PNG
});

enum Id { THE_4_BF58_DD8_D48988_D16_D941735, THE_4_BF58_DD8_D48988_D1_E0931735, THE_4_BF58_DD8_D48988_D1_DC931735 }

final idValues = EnumValues({
  "4bf58dd8d48988d16d941735": Id.THE_4_BF58_DD8_D48988_D16_D941735,
  "4bf58dd8d48988d1dc931735": Id.THE_4_BF58_DD8_D48988_D1_DC931735,
  "4bf58dd8d48988d1e0931735": Id.THE_4_BF58_DD8_D48988_D1_E0931735
});

enum Name { CAF, COFFEE_SHOP, SALON_DE_TH }

final nameValues = EnumValues({
  "Café": Name.CAF,
  "Coffee Shop": Name.COFFEE_SHOP,
  "Salon de thé": Name.SALON_DE_TH
});

enum PluralName { CAFS, COFFEE_SHOPS, SALONS_DE_TH }

final pluralNameValues = EnumValues({
  "Cafés": PluralName.CAFS,
  "Coffee Shops": PluralName.COFFEE_SHOPS,
  "Salons de thé": PluralName.SALONS_DE_TH
});

class Contact {
  Contact();

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
  );

  Map<String, dynamic> toJson() => {
  };
}

class HereNow {
  int count;
  HereNowSummary summary;
  List<dynamic> groups;

  HereNow({
    this.count,
    this.summary,
    this.groups,
  });

  factory HereNow.fromJson(Map<String, dynamic> json) => HereNow(
    count: json["count"],
    summary: hereNowSummaryValues.map[json["summary"]],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "summary": hereNowSummaryValues.reverse[summary],
    "groups": List<dynamic>.from(groups.map((x) => x)),
  };
}

enum HereNowSummary { PERSONNE_ICI }

final hereNowSummaryValues = EnumValues({
  "Personne ici": HereNowSummary.PERSONNE_ICI
});

class Location {
  String address;
  double lat;
  double lng;
  List<LabeledLatLng> labeledLatLngs;
  String postalCode;
  Cc cc;
  HeaderFullLocation city;
  String state;
  Country country;
  List<String> formattedAddress;
  String crossStreet;

  Location({
    this.address,
    this.lat,
    this.lng,
    this.labeledLatLngs,
    this.postalCode,
    this.cc,
    this.city,
    this.state,
    this.country,
    this.formattedAddress,
    this.crossStreet,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    address: json["address"] == null ? null : json["address"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    labeledLatLngs: List<LabeledLatLng>.from(json["labeledLatLngs"].map((x) => LabeledLatLng.fromJson(x))),
    postalCode: json["postalCode"] == null ? null : json["postalCode"],
    cc: ccValues.map[json["cc"]],
    city: json["city"] == null ? null : headerFullLocationValues.map[json["city"]],
    state: json["state"] == null ? null : json["state"],
    country: countryValues.map[json["country"]],
    formattedAddress: List<String>.from(json["formattedAddress"].map((x) => x)),
    crossStreet: json["crossStreet"] == null ? null : json["crossStreet"],
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "lat": lat,
    "lng": lng,
    "labeledLatLngs": List<dynamic>.from(labeledLatLngs.map((x) => x.toJson())),
    "postalCode": postalCode == null ? null : postalCode,
    "cc": ccValues.reverse[cc],
    "city": city == null ? null : headerFullLocationValues.reverse[city],
    "state": state == null ? null : state,
    "country": countryValues.reverse[country],
    "formattedAddress": List<dynamic>.from(formattedAddress.map((x) => x)),
    "crossStreet": crossStreet == null ? null : crossStreet,
  };
}

enum HeaderFullLocation { NANTES }

final headerFullLocationValues = EnumValues({
  "Nantes": HeaderFullLocation.NANTES
});

enum Country { FRANCE }

final countryValues = EnumValues({
  "France": Country.FRANCE
});

class LabeledLatLng {
  Label label;
  double lat;
  double lng;

  LabeledLatLng({
    this.label,
    this.lat,
    this.lng,
  });

  factory LabeledLatLng.fromJson(Map<String, dynamic> json) => LabeledLatLng(
    label: labelValues.map[json["label"]],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "label": labelValues.reverse[label],
    "lat": lat,
    "lng": lng,
  };
}

enum Label { DISPLAY }

final labelValues = EnumValues({
  "display": Label.DISPLAY
});

class Photos {
  int count;
  List<dynamic> groups;

  Photos({
    this.count,
    this.groups,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    count: json["count"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "groups": List<dynamic>.from(groups.map((x) => x)),
  };
}

class Stats {
  int tipCount;
  int usersCount;
  int checkinsCount;
  int visitsCount;

  Stats({
    this.tipCount,
    this.usersCount,
    this.checkinsCount,
    this.visitsCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    tipCount: json["tipCount"],
    usersCount: json["usersCount"],
    checkinsCount: json["checkinsCount"],
    visitsCount: json["visitsCount"],
  );

  Map<String, dynamic> toJson() => {
    "tipCount": tipCount,
    "usersCount": usersCount,
    "checkinsCount": checkinsCount,
    "visitsCount": visitsCount,
  };
}

class SuggestedFilters {
  String header;
  List<Filter> filters;

  SuggestedFilters({
    this.header,
    this.filters,
  });

  factory SuggestedFilters.fromJson(Map<String, dynamic> json) => SuggestedFilters(
    header: json["header"],
    filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
  };
}

class Filter {
  String name;
  String key;

  Filter({
    this.name,
    this.key,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    name: json["name"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}


class Activity {
}