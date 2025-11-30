class GetAllFavoritesMovies {
  GetAllFavoritesMovies({
    this.message,
    this.data,
  });

  GetAllFavoritesMovies.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  Data.fromJson(dynamic json) {
    if (json['movieId'] != null) {
      movieId = int.tryParse(json['movieId'].toString()) ?? (json['movieId'] is int ? json['movieId'] : null);
    }
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
  int? movieId;
  dynamic name;
  dynamic rating;
  dynamic imageURL;
  dynamic year;

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': name,
      'rating': rating,
      'imageURL': imageURL,
      'year': year,
    };
  }
}
