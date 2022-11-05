import 'package:ecommerce_mobile/screens/product/product_show.dart';
import 'package:ecommerce_mobile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ecommerce_mobile/screens/product/search_page.dart';
import 'package:ecommerce_mobile/widgets/app_drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
  final searchController=TextEditingController();
  List<dynamic> items=[];

  @override
  void initState() {
    readToken();
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async{
    var res=await Dio().get('/products');
    items=jsonDecode(res.data);
  } 
  
  void readToken() async{
    String? token=await storage.read(key: 'token');
    Provider.of<Auth>(context,listen: false).tryToken(token);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0Xff43db80),
        title: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText:'I am looking for',
              fillColor:Colors.white,
              filled: true,
              hintText: 'I am looking for...'
            ),
          ),
        centerTitle: true,
        actions:[
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SearchPage(),settings:RouteSettings(arguments:{searchController.text})));
            },
            icon:Icon(Icons.search)
          ),
        ]
      ),
      body: items.length==0 ?
      const Center(
        child: SpinKitFadingCube(
          size:140,
          color: Color(0Xff43db80)
        )
      )
      : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              var product=items[index];
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProductShow(),settings:RouteSettings(arguments:{product})));
            },
            child: Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https://cdn.pixabay.com/photo/2022/09/26/23/26/african-american-7481724_960_720.jpg'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('item title',style:TextStyle(fontSize:17,fontWeight: FontWeight.w600)),
                      Text('item.description',style:TextStyle(fontSize:15,color: Colors.grey[600]))
                    ]
                  )
                ]
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(5)
              ), 
            ),
          );
        },
      )
    );
  }
}
