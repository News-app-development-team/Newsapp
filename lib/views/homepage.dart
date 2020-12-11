import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phnauthnew/helper/data.dart';
import 'package:phnauthnew/helper/widgets.dart';
import 'package:phnauthnew/models/categorie_model.dart';
import 'package:phnauthnew/screens/about_screen.dart';
import 'package:phnauthnew/screens/calander.dart';
import 'package:phnauthnew/screens/settings.dart';
import 'package:phnauthnew/services/authservice.dart';
import 'package:phnauthnew/views/search_view.dart';
import '../helper/news.dart';
import 'categorie_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _loading;
  var newslist;
  bool search=true;
  String keyword;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // UserAccountsDrawerHeader(
            //   accountName: Text('kabali'),
            //   accountEmail: Text('kabali@gmail.com'),
            //   currentAccountPicture: GestureDetector(
            //     child: CircleAvatar(
            //       backgroundColor: Colors.grey,
            //       child: Icon(Icons.person),
            //     ),
            //   ),
            //   decoration: BoxDecoration(
            //     color: Colors.pink,
            //   ),
            // ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomePage()
                ));
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color: Colors.pink,),
              ),
            ),
            // InkWell(
            //   onTap: (){},
            //   child: ListTile(
            //     title: Text('My Account'),
            //     leading: Icon(Icons.person,color: Colors.pink,),
            //   ),
            // ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Calander()
                ));
              },
              child: ListTile(
                title: Text('Calendar'),
                leading: Icon(Icons.calendar_today,color: Colors.pink,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => settings()
                ));
              },
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings,color: Colors.blue,),
              ),
            ),InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => About()
                ));
              },
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help,color: Colors.green,),
              ),
            ),
            InkWell(
              onTap: (){
                AuthService().signOut();
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.phonelink_erase,color: Colors.red,),
              ),
            ),
          ],
        ),
      ),
      appBar: search?AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
              print(' search tapped');
              setState(() {
                search=false;
              });
              // AuthService().signOut();
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){
              print('tapped');
             AuthService().signOut();
            },
            icon: Icon(Icons.phonelink_erase),
          ),
        ],
      ):AppBar(
        title: TextField(
          onChanged: (val){
            keyword=val;
          },
        ),
        leading: IconButton(
          onPressed: (){
            setState(() {
              search=true;
            });
            // AuthService().signOut();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          IconButton(
            onPressed: (){
              print('tapped');
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => searchnews(
                    keyword: keyword.toLowerCase(),
                  )
              ));
              // AuthService().signOut();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
