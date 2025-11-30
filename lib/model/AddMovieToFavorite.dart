/// message : "Added to favourite successfully"
/// data : {"movieId":"movieIdi","name":"test","rating":2.4,"imageURL":"https//imagelink","year":"2002"}

class AddMovieToFavorite {
  AddMovieToFavorite({
      this.message, 
      this.data,});

  AddMovieToFavorite.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// movieId : "movieIdi"
/// name : "test"
/// rating : 2.4
/// imageURL : "https//imagelink"
/// year : "2002"

class Data {
  Data({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  Data.fromJson(dynamic json) {
    movieId = int.tryParse(json['movieId'].toString());
    name = json['name'];
    rating = (json['rating'] as num).toDouble();
    imageURL = json['imageURL'];
    year = int.tryParse(json['year'].toString());
  }

  int? movieId;
  String? name;
  double? rating;
  String? imageURL;
  int? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
