import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/noteview.dart';
import 'package:noteapp/services/db.dart';
import 'model/mynote.dart';

class searchView extends StatefulWidget {
  const searchView({super.key});

  @override
  State<searchView> createState() => _searchViewState();
}

class _searchViewState extends State<searchView> {

  List<note?> SearchResultNotes =[];
  bool isLoading = false;

  void searchResult(String query) async{
    SearchResultNotes.clear();
    setState(() {
      isLoading=true;
    });

    final resultids=await noteDatabase.instance.getNoteString(query);
    print(resultids);
    List<note ? > tempResult = [];
    resultids.forEach((id) async {
      final searchnote = await noteDatabase.instance.readOneNote(id);
      tempResult.add(searchnote);
      setState(() {
        SearchResultNotes.add(searchnote);
      });

    });

    setState(() {
      isLoading=false;
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: white.withOpacity(0.1)),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context); // ends the particular current activity
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: white,
                      )),
                  Expanded(
                    // it is neccassry to use when Row widget is used in TextField
                    child: TextField(
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.search, // sets the icons of enter in user keyboard
                      style: const TextStyle(
                          // styling for the inoout text
                          color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none, // sets the border of the field
                          focusedBorder: InputBorder
                              .none, // when the field get tapped then what will be border
                          errorBorder:
                              InputBorder.none, // obviously the border error
                          disabledBorder: InputBorder
                              .none, // when user has left action over the text field
                          hintText: "Search Your Notes ",
                          hintStyle: TextStyle(
                              color: white.withOpacity(
                                  0.5), // used to set the transparency of the color
                              fontSize: 16)),
                          onSubmitted: (value) {
                            searchResult(value);
                          },   
                    ),
                  ),
                ],
              ),
              isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) :  NoteSectionAll()
            ],
          ),
        ),
      ),
    );
  }

   Widget NoteSectionAll() {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "SEARCH RESULTS",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: SearchResultNotes.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => 
              InkWell(
                onTap: () 
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => noteview(Note: SearchResultNotes[index] )));
                },
                child: 
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(SearchResultNotes[index]!.title,
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(SearchResultNotes[index]!.content.length > 250
                              ? "${SearchResultNotes[index]!.content.substring(0, 250)}..."
                              : SearchResultNotes[index]!.content,

                      style: TextStyle(color: white),
                    )
                  ],
                ),
              ),
              
              )
            )
            ),
      ],
    )
    );
  }
}
