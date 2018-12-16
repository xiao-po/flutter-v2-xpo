class User {
  String username;
  String uri;
  String status;
  int id;
  String url;
  String github;
  String tagline;
  String bio;
  String avatar_mini;
  String avatar_normal;
  String avatar_large;
  DateTime created;
  User({
    this.username,
    this.uri,
    this.status,
    this.id,
    this.github,
    this.tagline,
    this.bio,
    this.avatar_mini,
    this.avatar_large,
    this.avatar_normal,
    this.created
  }) ;
  User.simple({
    this.username,
    this.uri,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    if ((new RegExp("^//")).firstMatch(json['avatar_mini']) != null) {
      json['avatar_mini'] = 'https:' +json ['avatar_mini'];
    }

    if ((new RegExp("^//")).firstMatch(json['avatar_large']) != null) {
      json['avatar_large'] = 'https:' +json ['avatar_large'];
    }

    if ((new RegExp("^//")).firstMatch(json['avatar_normal']) != null) {
      json['avatar_normal'] = 'https:' +json ['avatar_normal'];
    }

    return new User(
      username: json['username'],
      uri: json['uri'],
      status: json['status'],
      id: json['id'],
      github: json['github'],
      tagline: json['tagline'],
      bio: json['bio'],
      avatar_mini: json['avatar_mini'],
      avatar_large: json['avatar_large'],
      avatar_normal: json['avatar_normal'],
      created: new DateTime.fromMicrosecondsSinceEpoch(json['created']),
    );
  }
}