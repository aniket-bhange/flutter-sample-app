import 'package:flutter/material.dart';

class NavbarHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      
      builder: (context, constrains){
        // print(constrains.biggest.width);
        return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: Container(
                  width: constrains.biggest.width-20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // IconButton(
                      //   icon: Icon(Icons.arrow_back_ios), 
                      //   onPressed: (){},
                      //   color: Colors.white,
                      // ),
                      SizedBox(width: 30.0,),
                      Container(
                        width:125.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.filter_list), 
                              onPressed: (){},
                              color: Colors.white,
                            ),
                              IconButton(
                              icon: Icon(Icons.menu), 
                              onPressed: (){},
                              color: Colors.white,
                            ),
                          ], 
                        )
                      ),
                    ],
                  ),
                )
              ),

              //2nd row for text
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                child: Row(
                  children: <Widget>[
                    Text("Healthy", style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text("Food", style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 28.0,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      )),
                    ),
                    
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

