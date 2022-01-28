class NotsModel {
  String title;
  String imageUrl;
  String user;
  String content;

/*  NotsModel(Map<String,dynamic> parsedJson){
    title = //parsedJson['title'];
    imageUrl = //parsedJson['image'];
    user = //parsedJson['user'];
    content =
    //parsedJson['content'];
  }
/
/String toString(){
    return title;
  }


   */
  NotsModel({this.title,this.user,this.content,this.imageUrl});
}