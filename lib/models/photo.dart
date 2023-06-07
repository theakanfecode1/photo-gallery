class Photo {
  Photo({
    required this.id,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.user,
  });
  late final String id;
  late final String slug;
  late final String createdAt;
  late final String updatedAt;
  late final String blurHash;
  late final String description;
  late final String altDescription;
  late final Urls urls;
  late final Links links;
  late final User user;

  Photo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    blurHash = json['blur_hash'];
    description = json['description'] ?? '';
    altDescription = json['alt_description'];
    urls = Urls.fromJson(json['urls']);
    links = Links.fromJson(json['links']);
    user = User.fromJson(json['user']);
  }
}

class Urls {
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });
  late final String raw;
  late final String full;
  late final String regular;
  late final String small;
  late final String thumb;
  late final String smallS3;

  Urls.fromJson(Map<String, dynamic> json){
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }

}

class Links {
  Links({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });
  late final String self;
  late final String html;
  late final String download;
  late final String downloadLocation;

  Links.fromJson(Map<String, dynamic> json){
    self = json['self'];
    html = json['html'];
    download = json['download'];
    downloadLocation = json['download_location'];
  }
}


class Social {
  Social({
    required this.instagramUsername,
    required this.portfolioUrl,
    required this.twitterUsername,
    required this.paypalEmail,
  });
  late final String instagramUsername;
  late final String portfolioUrl;
  late final String twitterUsername;
  late final String paypalEmail;

  Social.fromJson(Map<String, dynamic> json){
    instagramUsername = json['instagram_username'] ?? '';
    portfolioUrl = json['portfolio_url'] ?? '';
    twitterUsername = json['twitter_username'] ?? '';
    paypalEmail =  json['paypal_email'] ?? '';
  }
}


class User {
  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });
  late final String id;
  late final String updatedAt;
  late final String username;
  late final String name;
  late final String firstName;
  late final String lastName;
  late final String twitterUsername;
  late final String portfolioUrl;
  late final String bio;
  late final String location;
  late final Links links;
  late final String instagramUsername;
  late final int totalCollections;
  late final int totalLikes;
  late final int totalPhotos;
  late final bool acceptedTos;
  late final bool forHire;
  late final Social social;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'] ?? '';
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'] ?? '';
    links = Links.fromJson(json['links']);
    instagramUsername = json['instagram_username'] ?? '';
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = Social.fromJson(json['social']);
  }
}