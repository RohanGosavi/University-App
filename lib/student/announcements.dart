//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/homepage.dart';
import 'package:bottom_navigation_demo/backend/announcementback.dart';
import 'package:bottom_navigation_demo/student/announce.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';



class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {

  Announcementlist obj = new Announcementlist();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Announcements',
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                color: color2,
                fontSize: 30),
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height/3.8,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: obj.getData(),
              builder: (context, AsyncSnapshot projectSnap) {
                if(!projectSnap.hasData){
                  return Center(child: CircularProgressIndicator());
                }else {
                  print(projectSnap.data);
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int i) {
                      // setState(() {
                      //   _index = i;
                      // });
                    },
                    //scrollDirection: Axis.horizontal
                    itemBuilder: (ctx, i){
                      Announcementlist data = projectSnap.data[projectSnap.data.length-i-1];
                        return InkWell(
                          onTap:(){
                            Navigator.push(context, ScaleRoute(page: Announce(announcement: data.announcement,)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 70,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              boxShadow: shadows,
                              color: color1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: SvgPicture.asset('assets/illustrations/announce.svg',),
                                    // SvgPicture.asset(
                                    //   annList[i].annAsset,
                                    // ),
                                  ),
                                ),
                                Text(
                                  data.announcement,
                                  overflow: TextOverflow.ellipsis,maxLines: 2,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: color2,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data.by,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: color2,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                    itemCount: projectSnap.data.length,
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
// class Announce {
//   final int userId;
//   final int id;
//   final String title;
//   //final String announcement;
//   //final String annAsset;
//
//   Announce({this.userId,this.id,this.title});
//   factory Announce.fromJson(Map<String,dynamic> json){
//     return Announce(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title']
//     );
//   }
// }

// class AnnounceList{
//   final List<Announce> announcelist;
//   AnnounceList({this.announcelist});
//
//   factory AnnounceList.fromJson(List<dynamic> parsedJson){
//     List<Announce> announce = parsedJson.map((i)=>Announce.fromJson(i)).toList();
//     return new AnnounceList(
//       announcelist: announce,
//     );
//   }
//
// }

// List<Announce> annList = [
//   Announce(annAsset: "assets/sinhgad.png",announcement: "Please complete your admission process of year 2020-21 before 21 August"),
//   Announce(annAsset: "assets/sinhgad.png",announcement: "Please complete your admission process"),
//   Announce(annAsset: "assets/sinhgad.png",announcement: "Please complete your admission process"),
//   Announce(annAsset: "assets/sinhgad.png",announcement: "Please complete your admission process"),
// ];