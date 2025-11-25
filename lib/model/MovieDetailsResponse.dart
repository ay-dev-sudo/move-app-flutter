class MovieDetailsResponse {
  MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    this.data,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      status: json['status'] as String? ?? '',
      statusMessage: json['status_message'] as String? ?? '',
      data: json['data'] != null ? MovieDetailsData.fromJson(json['data']) : null,
    );
  }

  String status;
  String statusMessage;
  MovieDetailsData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class MovieDetailsData {
  MovieDetailsData({this.movie});

  factory MovieDetailsData.fromJson(Map<String, dynamic> json) {
    return MovieDetailsData(
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
    );
  }

  Movie? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) map['movie'] = movie!.toJson();
    return map;
  }
}

class Movie {
  Movie({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    this.descriptionIntro = '',
    this.descriptionFull = '',
    this.ytTrailerCode = '',
    this.language = '',
    this.mpaRating = '',
    this.backgroundImage = '',
    this.backgroundImageOriginal = '',
    this.smallCoverImage = '',
    this.mediumCoverImage = '',
    this.largeCoverImage = '',
    this.torrents = const [],
    this.dateUploaded = '',
    this.dateUploadedUnix = 0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      slug: json['slug'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
      runtime: json['runtime'] ?? 0,
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      likeCount: json['like_count'] ?? 0,
      descriptionIntro: json['description_intro'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal: json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      torrents: json['torrents'] != null
          ? List<Torrents>.from(json['torrents'].map((x) => Torrents.fromJson(x)))
          : [],
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }

  int id;
  String url;
  String imdbCode;
  String title;
  String titleEnglish;
  String titleLong;
  String slug;
  int year;
  double rating;
  int runtime;
  List<String> genres;
  int likeCount;
  String descriptionIntro;
  String descriptionFull;
  String ytTrailerCode;
  String language;
  String mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  List<Torrents> torrents;
  String dateUploaded;
  int dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['like_count'] = likeCount;
    map['description_intro'] = descriptionIntro;
    map['description_full'] = descriptionFull;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['torrents'] = torrents.map((v) => v.toJson()).toList();
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}

class Torrents {
  Torrents({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    this.isRepack = '0',
    this.videoCodec = '',
    this.bitDepth = '',
    this.audioChannels = '',
    this.seeds = 0,
    this.peers = 0,
    this.size = '',
    this.sizeBytes = 0,
    this.dateUploaded = '',
    this.dateUploadedUnix = 0,
  });

  factory Torrents.fromJson(Map<String, dynamic> json) {
    return Torrents(
      url: json['url'] ?? '',
      hash: json['hash'] ?? '',
      quality: json['quality'] ?? '',
      type: json['type'] ?? '',
      isRepack: json['is_repack'] ?? '0',
      videoCodec: json['video_codec'] ?? '',
      bitDepth: json['bit_depth'] ?? '',
      audioChannels: json['audio_channels'] ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
      size: json['size'] ?? '',
      sizeBytes: json['size_bytes'] ?? 0,
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }

  String url;
  String hash;
  String quality;
  String type;
  String isRepack;
  String videoCodec;
  String bitDepth;
  String audioChannels;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  String dateUploaded;
  int dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}
