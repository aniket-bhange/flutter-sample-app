import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutritionapp/Home/HomeInterface.dart';
import 'package:nutritionapp/Navbar/Navbar.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<bool> _onbackPress(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => SystemNavigator.pop(),
            child: Text("YES"),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPress,
      child: Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        
        body: Column(
          children: <Widget>[
            NavbarHome(),
            SizedBox(height: 40.0,),
            Container(
              height: MediaQuery.of(context).size.height - 198.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0))
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0), 
                    child: Container(
                      height: MediaQuery.of(context).size.height - 320.0,
                      child: ListView(
                        children: <Widget>[
                          _footItem('assets/images/plate1.png', "Salmon Bowl", '\$24.00'),
                          _footItem('assets/images/plate2.png', "Spring Bowl", '\$22.00'),
                          _footItem('assets/images/plate6.png', "Avocado Bowl", '\$26.00'),
                          _footItem('assets/images/plate5.png', "Berry Bowl", '\$39.00'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0,
                              )
                            ),
                            child: Center(
                              child: Icon(Icons.search, color: Colors.black,),
                            ),
                          ),
                          Container(
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0,
                              )
                            ),
                            child: Center(
                              child: Icon(Icons.shopping_basket, color: Colors.black,),
                            ),
                          ),
                            Container(
                            height: 65.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFF1C1428),
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0,
                              )
                            ),
                            child: Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  ),
                              ),
                            ),
                          ),
                          ],
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }

  Widget _footItem(String imagePath, String foodName, String price){
    return Padding(
      padding: EdgeInsets.only(left:10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/food-details', 
            arguments: FoodDetailsArguments(imagePath, foodName, price)
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
               children: <Widget>[
                Hero(
                   tag: imagePath,
                   child: Image(
                     image: AssetImage(imagePath),
                     fit: BoxFit.cover,
                     height: 75.0,
                     width: 75.0,

                   ),
                ),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      foodName,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
               ], 
              ),
            ),
            IconButton(
              icon: Icon(Icons.add), 
              onPressed: (){},
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

