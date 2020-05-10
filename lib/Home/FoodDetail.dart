import 'package:flutter/material.dart';
import 'package:nutritionapp/Home/HomeInterface.dart';
import 'package:nutritionapp/Home/VScrollList.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodDetailsArguments arguments;
  
  FoodDetailScreen(this.arguments);

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  
  final TextStyle textStyle = new TextStyle(
    fontFamily: "Montserrat",
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = new AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios), 
        onPressed: (){
          Navigator.of(context).pop();
        },
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        'Details',
        style: textStyle.copyWith(fontSize: 18.0),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.more_horiz), color: Colors.white, onPressed: (){})
      ],
    );

    print(widget.arguments.heroTag);
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: appBar,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 62.0,
                color: Colors.transparent,
              ),

              Positioned(
                top: 95.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0), 
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white
                  ),
                  height: MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width,
                )
              ),

              Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width/2) - 125.0,
                child: Hero(
                  tag: widget.arguments.heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.arguments.heroTag),
                        fit: BoxFit.cover
                      )
                    ),
                    height: 250.0,
                    width: 250.0,
                  ),
                  
                ),
              ),

              Positioned(
                top: 300.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          widget.arguments.foodName.split(" ")[0],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          widget.arguments.foodName.split(" ")[1],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.w100
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.arguments.foodPrice,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                              width: 0.4,
                              height: 40.0,
                              color: Colors.grey,
                            ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(),
                          child: Container(
                            height: 40.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(17.0),
                              color: Color(0xFF7A9BEE)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7A9BEE),
                                      borderRadius: BorderRadius.circular(7.0)
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 3.0,),
                                Text(
                                  "2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontSize: 20.0
                                  ),
                                ),
                                SizedBox(width: 3.0,),
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7.0)
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xFF7A9BEE),
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),                          
                        )
                      ],
                    ),
                    SizedBox(height: 60.0,),
                    VScrollList([{
                      "title": "weight",
                      'qunatity': '200',
                      'unit': "G",
                      'id': 20
                    },{
                      "title": "CALORIES",
                      'qunatity': '267',
                      'unit': "CAL",
                      'id': 30
                    },{
                      "title": "VITAMINS",
                      'qunatity': 'A, B6',
                      'unit': "VIT",
                      'id': 40
                    },{
                      "title": "AVAIL",
                      'qunatity': 'NO',
                      'unit': "AV",
                      'id': 50
                    },
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
    
    // return Scaffold(
    //   backgroundColor: Color(0xFF7A9BEE),
    // );
    
  }
}