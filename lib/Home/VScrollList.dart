import 'package:flutter/material.dart';

class VScrollList extends StatefulWidget {

  final List catergorylist;
  VScrollList(this.catergorylist);

  @override
  _VScrollListState createState() => _VScrollListState();
}

class _VScrollListState extends State<VScrollList> {

  int selectedId = 20;

  @override
  Widget build(BuildContext context) {

    List<Widget> childs = [];
    for (var item in widget.catergorylist) {
      childs.add(_getScrolItems(item['id'], item['title'], item['qunatity'], item['unit']));
      childs.add(SizedBox(width: 10.0));
    }

    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[...childs],
      ),
    );
  }

  Widget _getScrolItems(int id, String title, String info, String unit){

    return InkWell(
      onTap: (){
        onSelect(id);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: selectedId == id ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: selectedId == id ? Colors.transparent : Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 1.05,
          ),

        ),
        height: 80.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  color: selectedId == id ? Colors.white : Colors.grey.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info, style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    color: selectedId == id ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(unit, style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    color: selectedId == id ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSelect(int id){
    setState(() {
      selectedId = id;
    });
  }
}