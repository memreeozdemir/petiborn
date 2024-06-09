class Posts {
  final List<Post>? posts;
  Posts({required this.posts});

  factory Posts.fromJson(Map<String, dynamic>? json) {
    List<Post> posts = [];

    if (json != null) {
      for (var i in json['posts']) {
        posts.add(Post.fromJson(i));
      }
    }

    return Posts(posts: posts);
  }
}

class Post {
  final String? email;
  final String? fullname;
  final String? username;
  final List<String>? pets;

  Post({
    this.email,
    this.fullname,
    this.username,
    this.pets,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      email: json['email'],
      fullname: json['fullname'],
      username: json['username'],
      pets: List<String>.from(json['pets']),
    );
  }
}
