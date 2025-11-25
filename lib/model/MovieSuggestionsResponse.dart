
class MovieSuggestionsResponse {
  MovieSuggestionsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
      });

  MovieSuggestionsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }

    return map;
  }

}

/// server_time : 1764073456
/// server_timezone : "CET"
/// api_version : 2
/// execution_time : "0 ms"


/// movie_count : 0
/// movies : [{"id":664,"url":"https://yts.lt/movies/chaos-2005","imdb_code":"tt0402910","title":"Chaos","title_english":"Chaos","title_long":"Chaos (2005)","slug":"chaos-2005","year":2005,"rating":6.4,"runtime":106,"genres":["Action","Crime","Drama","Thriller"],"summary":"In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil","description_full":"In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil","synopsis":"In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil","yt_trailer_code":"IzWbjvuIgAc","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/Chaos_2005/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/Chaos_2005/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/Chaos_2005/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/Chaos_2005/medium-cover.jpg","state":"ok","torrents":[{"url":"https://yts.lt/torrent/download/CDED33F7FBF3E4E073778848FAD17674C0A35B82","hash":"CDED33F7FBF3E4E073778848FAD17674C0A35B82","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":8,"peers":2,"size":"809.06 MB","size_bytes":848360899,"date_uploaded":"2015-10-31 22:22:51","date_uploaded_unix":1446326571},{"url":"https://yts.lt/torrent/download/7569B45EA7F070575F44874F9BE259D4549FC50B","hash":"7569B45EA7F070575F44874F9BE259D4549FC50B","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":27,"peers":1,"size":"1.96 GB","size_bytes":2104533975,"date_uploaded":"2022-05-07 14:38:18","date_uploaded_unix":1651927098}],"date_uploaded":"2015-10-31 22:22:51","date_uploaded_unix":1446326571},{"id":795,"url":"https://yts.lt/movies/crank-2006","imdb_code":"tt0479884","title":"Crank","title_english":"Crank","title_long":"Crank (2006)","slug":"crank-2006","year":2006,"rating":6.9,"runtime":88,"genres":["Action","Crime","Thriller"],"summary":"Poisoned by the potent and deadly mix of synthetic drugs called \"The Beijing Cocktail\" for getting in the way of the Triads, the tough-as-nails British hitman living in Los Angeles, Chev Chelios, wakes up with a terrible headache. With less than an hour to live, Chev will have to use all the help he can get from his doctor, and use every trick in the book, to consistently keep his heart rate up so that the adrenaline in his bloodstream staves off the effects of the deadly toxin. Now, his heart is pounding faster than any other human being, and as Chelios darts across the city's streets in search of an antidote and the arrogant criminal, Ricky Verona, to exact his revenge, he finds himself compelled to pick fights with no-nonsense drug dealers, murderous assassins, and an army of thugs. But, can Chelios stay alive long enough to protect those he loves, and make it through the day?—Nick Riganas","description_full":"Poisoned by the potent and deadly mix of synthetic drugs called \"The Beijing Cocktail\" for getting in the way of the Triads, the tough-as-nails British hitman living in Los Angeles, Chev Chelios, wakes up with a terrible headache. With less than an hour to live, Chev will have to use all the help he can get from his doctor, and use every trick in the book, to consistently keep his heart rate up so that the adrenaline in his bloodstream staves off the effects of the deadly toxin. Now, his heart is pounding faster than any other human being, and as Chelios darts across the city's streets in search of an antidote and the arrogant criminal, Ricky Verona, to exact his revenge, he finds himself compelled to pick fights with no-nonsense drug dealers, murderous assassins, and an army of thugs. But, can Chelios stay alive long enough to protect those he loves, and make it through the day?—Nick Riganas","synopsis":"Poisoned by the potent and deadly mix of synthetic drugs called \"The Beijing Cocktail\" for getting in the way of the Triads, the tough-as-nails British hitman living in Los Angeles, Chev Chelios, wakes up with a terrible headache. With less than an hour to live, Chev will have to use all the help he can get from his doctor, and use every trick in the book, to consistently keep his heart rate up so that the adrenaline in his bloodstream staves off the effects of the deadly toxin. Now, his heart is pounding faster than any other human being, and as Chelios darts across the city's streets in search of an antidote and the arrogant criminal, Ricky Verona, to exact his revenge, he finds himself compelled to pick fights with no-nonsense drug dealers, murderous assassins, and an army of thugs. But, can Chelios stay alive long enough to protect those he loves, and make it through the day?—Nick Riganas","yt_trailer_code":"218nsccFpag","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/Crank_2006/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/Crank_2006/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/Crank_2006/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/Crank_2006/medium-cover.jpg","state":"ok","torrents":[{"url":"https://yts.lt/torrent/download/EDB4ECDB8976E4CDD28A1DC3B86240655B80867E","hash":"EDB4ECDB8976E4CDD28A1DC3B86240655B80867E","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":5,"peers":3,"size":"606.98 MB","size_bytes":636464660,"date_uploaded":"2015-10-31 22:39:18","date_uploaded_unix":1446327558},{"url":"https://yts.lt/torrent/download/0C4DBD147A2CC5CFDDEA7CD9012AB9B59C5D02E3","hash":"0C4DBD147A2CC5CFDDEA7CD9012AB9B59C5D02E3","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":89,"peers":8,"size":"1.32 GB","size_bytes":1417339208,"date_uploaded":"2015-10-31 22:39:20","date_uploaded_unix":1446327560},{"url":"https://yts.lt/torrent/download/78CB7DB8FFAD72835A714B016D75196F9C4B4D6A","hash":"78CB7DB8FFAD72835A714B016D75196F9C4B4D6A","quality":"2160p","is_repack":"0","video_codec":"x265","bit_depth":"10","audio_channels":"5.1","seeds":33,"peers":6,"size":"4.24 GB","size_bytes":4552665334,"date_uploaded":"2023-07-30 06:17:43","date_uploaded_unix":1690690663}],"date_uploaded":"2015-10-31 22:39:18","date_uploaded_unix":1446327558},{"id":1765,"url":"https://yts.lt/movies/killer-elite-2011","imdb_code":"tt1448755","title":"Killer Elite","title_english":"Killer Elite","title_long":"Killer Elite (2011)","slug":"killer-elite-2011","year":2011,"rating":6.4,"runtime":116,"genres":["Action","Crime","History","Thriller"],"summary":"Loosely-based on a true story, Killer Elite pits two of the world's most elite operatives--Danny, a ruthless killer-for-hire (Jason Statham); and Hunter, his longtime mentor (Robert De Niro)--against the cunning leader of a secret society of former Special Air Service operatives(Clive Owen). Covering the globe from Australia to Paris, London, and the Middle East, Danny and Hunter are plunged into a highly-dangerous game of revenge and deception--where things are not always what they appear to be.—Anonymous","description_full":"Loosely-based on a true story, Killer Elite pits two of the world's most elite operatives--Danny, a ruthless killer-for-hire (Jason Statham); and Hunter, his longtime mentor (Robert De Niro)--against the cunning leader of a secret society of former Special Air Service operatives(Clive Owen). Covering the globe from Australia to Paris, London, and the Middle East, Danny and Hunter are plunged into a highly-dangerous game of revenge and deception--where things are not always what they appear to be.—Anonymous","synopsis":"Loosely-based on a true story, Killer Elite pits two of the world's most elite operatives--Danny, a ruthless killer-for-hire (Jason Statham); and Hunter, his longtime mentor (Robert De Niro)--against the cunning leader of a secret society of former Special Air Service operatives(Clive Owen). Covering the globe from Australia to Paris, London, and the Middle East, Danny and Hunter are plunged into a highly-dangerous game of revenge and deception--where things are not always what they appear to be.—Anonymous","yt_trailer_code":"2Q8VIPJAox8","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/Killer_Elite_2011/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/Killer_Elite_2011/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/Killer_Elite_2011/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/Killer_Elite_2011/medium-cover.jpg","state":"ok","torrents":[{"url":"https://yts.lt/torrent/download/0C833DA486A2FD7B8B16166C3C08180A86433295","hash":"0C833DA486A2FD7B8B16166C3C08180A86433295","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"751.37 MB","size_bytes":787868549,"date_uploaded":"2015-11-01 00:34:39","date_uploaded_unix":1446334479},{"url":"https://yts.lt/torrent/download/93CC3FA1EEB80BC06BF8F537133AB2F80ECFA175","hash":"93CC3FA1EEB80BC06BF8F537133AB2F80ECFA175","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":48,"peers":4,"size":"2.15 GB","size_bytes":2308544922,"date_uploaded":"2022-04-11 19:00:56","date_uploaded_unix":1649696456}],"date_uploaded":"2015-11-01 00:34:39","date_uploaded_unix":1446334479},{"id":3040,"url":"https://yts.lt/movies/the-art-of-war-2000","imdb_code":"tt0160009","title":"The Art of War","title_english":"The Art of War","title_long":"The Art of War (2000)","slug":"the-art-of-war-2000","year":2000,"rating":5.7,"runtime":117,"genres":["Action","Adventure","Crime","Thriller"],"summary":"Shaw is an operative for the United Nations' covert dirty-tricks squad, using espionage and quasi-ethical tactics to secure peace and cooperation. When a shipping container full of dead Vietnamese refugees turns up on the docks and China's ambassador is gunned down at a dinner celebrating a new trade agreement with China and the US, Shaw is framed for the murder and must evade the FBI and Triad gangsters to find out what is really going on.—Jeff Cross","description_full":"Shaw is an operative for the United Nations' covert dirty-tricks squad, using espionage and quasi-ethical tactics to secure peace and cooperation. When a shipping container full of dead Vietnamese refugees turns up on the docks and China's ambassador is gunned down at a dinner celebrating a new trade agreement with China and the US, Shaw is framed for the murder and must evade the FBI and Triad gangsters to find out what is really going on.—Jeff Cross","synopsis":"Shaw is an operative for the United Nations' covert dirty-tricks squad, using espionage and quasi-ethical tactics to secure peace and cooperation. When a shipping container full of dead Vietnamese refugees turns up on the docks and China's ambassador is gunned down at a dinner celebrating a new trade agreement with China and the US, Shaw is framed for the murder and must evade the FBI and Triad gangsters to find out what is really going on.—Jeff Cross","yt_trailer_code":"rKFmSpB-uGQ","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/The_Art_of_War_2000/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/The_Art_of_War_2000/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/The_Art_of_War_2000/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/The_Art_of_War_2000/medium-cover.jpg","state":"ok","torrents":[{"url":"https://yts.lt/torrent/download/376FC0D228B2C20EE59E7DA28D3F76BE9E948A23","hash":"376FC0D228B2C20EE59E7DA28D3F76BE9E948A23","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":2,"peers":0,"size":"866.42 MB","size_bytes":908507218,"date_uploaded":"2015-11-01 02:03:56","date_uploaded_unix":1446339836},{"url":"https://yts.lt/torrent/download/FE058481E079D3887866E93FE75910BA5089A9CF","hash":"FE058481E079D3887866E93FE75910BA5089A9CF","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":3,"peers":1,"size":"1.84 GB","size_bytes":1975684956,"date_uploaded":"2015-11-01 02:03:57","date_uploaded_unix":1446339837}],"date_uploaded":"2015-11-01 02:03:56","date_uploaded_unix":1446339836}]

class Data {
  Data({
      this.movieCount, 
      this.movies,});

  Data.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(Movies.fromJson(v));
      });
    }
  }
  int? movieCount;
  List<Movies>? movies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 664
/// url : "https://yts.lt/movies/chaos-2005"
/// imdb_code : "tt0402910"
/// title : "Chaos"
/// title_english : "Chaos"
/// title_long : "Chaos (2005)"
/// slug : "chaos-2005"
/// year : 2005
/// rating : 6.4
/// runtime : 106
/// genres : ["Action","Crime","Drama","Thriller"]
/// summary : "In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil"
/// description_full : "In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil"
/// synopsis : "In Seattle, detective Quentin Conners is unfairly suspended and his partner Jason York leaves the police force after a tragic shooting on Pearl Street Bridge, when the hostage and the criminal die. During a bank heist with a hostage situation, Conners is assigned in charge of the operation with the rookie Shane Dekker as his partner. The thieves, lead by Lorenz, apparently do not steal a penny from the bank. While chasing the gangsters, the police team disclose that they planted a virus in the system, stealing one billion dollars from the different accounts, using the principle of the Chaos Theory. Further, they find that Lorenz is killing his accomplices.—Claudio Carvalho, Rio de Janeiro, Brazil"
/// yt_trailer_code : "IzWbjvuIgAc"
/// language : "en"
/// mpa_rating : ""
/// background_image : "https://yts.lt/assets/images/movies/Chaos_2005/background.jpg"
/// background_image_original : "https://yts.lt/assets/images/movies/Chaos_2005/background.jpg"
/// small_cover_image : "https://yts.lt/assets/images/movies/Chaos_2005/small-cover.jpg"
/// medium_cover_image : "https://yts.lt/assets/images/movies/Chaos_2005/medium-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.lt/torrent/download/CDED33F7FBF3E4E073778848FAD17674C0A35B82","hash":"CDED33F7FBF3E4E073778848FAD17674C0A35B82","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":8,"peers":2,"size":"809.06 MB","size_bytes":848360899,"date_uploaded":"2015-10-31 22:22:51","date_uploaded_unix":1446326571},{"url":"https://yts.lt/torrent/download/7569B45EA7F070575F44874F9BE259D4549FC50B","hash":"7569B45EA7F070575F44874F9BE259D4549FC50B","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":27,"peers":1,"size":"1.96 GB","size_bytes":2104533975,"date_uploaded":"2022-05-07 14:38:18","date_uploaded_unix":1651927098}]
/// date_uploaded : "2015-10-31 22:22:51"
/// date_uploaded_unix : 1446326571

class Movies {
  Movies({
      this.id, 
      this.url, 
      this.imdbCode, 
      this.title, 
      this.titleEnglish, 
      this.titleLong, 
      this.slug, 
      this.year, 
      this.rating, 
      this.runtime, 
      this.genres, 
      this.summary, 
      this.descriptionFull, 
      this.synopsis, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.state, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Movies.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

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
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}

/// url : "https://yts.lt/torrent/download/CDED33F7FBF3E4E073778848FAD17674C0A35B82"
/// hash : "CDED33F7FBF3E4E073778848FAD17674C0A35B82"
/// quality : "720p"
/// is_repack : "0"
/// video_codec : "x264"
/// bit_depth : "8"
/// audio_channels : "2.0"
/// seeds : 8
/// peers : 2
/// size : "809.06 MB"
/// size_bytes : 848360899
/// date_uploaded : "2015-10-31 22:22:51"
/// date_uploaded_unix : 1446326571

class Torrents {
  Torrents({
      this.url, 
      this.hash, 
      this.quality, 
      this.isRepack, 
      this.videoCodec, 
      this.bitDepth, 
      this.audioChannels, 
      this.seeds, 
      this.peers, 
      this.size, 
      this.sizeBytes, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  String? url;
  String? hash;
  String? quality;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
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