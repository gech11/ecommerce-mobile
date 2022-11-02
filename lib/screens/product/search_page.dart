import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> items=[];

  Future<void> getItems() async{
    var res=await http.get(Uri.parse('http://127.0.0.1:8001/api/products/search'));
    items=jsonDecode(res.body);
  } 
  
  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: items.length==0 ?
      const Center(
        child: SpinKitFadingCube(
          size:140,
          color: Color(0Xff43db80)
        )
      )
      :ListView.builder(
        itemCount: items.length,
        itemBuilder: (context,index){
          return Container(
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
          );
        },
      )
    );
  }
}