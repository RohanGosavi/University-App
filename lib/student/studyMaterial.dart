//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/homepage.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/student/studymateriallist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StudyMaterial extends StatefulWidget {
  @override
  _StudyMaterialState createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  ScrollController controller = ScrollController();

  SubjectData obj = new SubjectData();
  List<SubjectData> detail;
  bool _loading;
  bool closeTopContainer = false;

  double topContainer = 0;

  @override
  void initState(){
    super.initState();
    controller.addListener(() {
      double value = controller.offset/100;
      setState(
          (){
            topContainer = value;
            closeTopContainer = controller.offset>50;
          }
      );
    });
    _loading = false;
    obj.getData(Studentinfo.testyear).then((value) {
      detail=value;
      print(detail);
      setState(() {
        _loading=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Study Material'),
            SvgPicture.asset('assets/illustrations/studying.svg',height: 75,),
          ],
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200) ,
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200) ,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : 200,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Container(
                    //color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Knowledge\nis Power',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff052250),
                                fontSize: 25),
                          ),
                        ),
                        
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/book.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _loading ?ListView.builder(
                controller: controller,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx,i)=> Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color1,
                  boxShadow: shadows,
                ),
                height: 130,
                width: MediaQuery.of(context).size.width - 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Icon(Icons.book_rounded,size: 50,)),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        detail[i].subject,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(context, ScaleRoute(page: StudyMaterialList(subject: detail[i].subject,)));
                        },
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
                itemCount: detail.length,
              ):Center(child: CircularProgressIndicator()),
            ),
          ],
        )
      ),
    );
  }
}

// List<String> _subjects = [
//   'MLA',
//   'ICS',
//   'BAI',
//   'STQA',
//   'SDM'
// ];