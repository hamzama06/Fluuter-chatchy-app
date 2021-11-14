

class UserModel {

    final id;
    final name;
    final email;
    final imageUri;


    UserModel(this.id, this.email, this.name, this.imageUri);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'imageUri': imageUri,
         };
  }

    static UserModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
     map['id'],
     map['email'],
     map['name'],
     map['imageUri']
      );
  }


 }