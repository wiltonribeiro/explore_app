class Author {

  String id;
  String username;
  String name;
  String twitterUsername;
  String portfolioURL;
  String bio;
  String location;
  String instagramUsername;
  String profileImage;


  Author.fromJSON(Map<String, dynamic> data){
    this.id = data["id"];
    this.username = data["username"];
    this.name = data["name"];
    this.twitterUsername = data["twitter_username"];
    this.portfolioURL = data["portfolio_url"];
    this.bio = data["bio"];
    this.location = data["location"];
    this.instagramUsername = data["instagram_username"];
    this.profileImage = data["profile_image"]["small"];
  }

  @override
  String toString() {
    return 'Author{id: $id, username: $username, name: $name, twitterUsername: $twitterUsername, portfolioURL: $portfolioURL, bio: $bio, location: $location, instagramUsername: $instagramUsername, profileImage: $profileImage}';
  }


}