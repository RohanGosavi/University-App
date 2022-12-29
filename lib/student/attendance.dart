//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/homepage.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        centerTitle: true,
        elevation: 0,
        //backgroundColor: color,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
      ),
      body: SafeArea(
        child: Container(
          //color: color,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: shadows,
                          color: color1),
                      height: 250,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Column(
                        children: [
                          Text(
                            'Overall Attendance',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff052250),
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: color2,
                                  child: Text(
                                    '81%',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: color1,
                                        fontSize: 30),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9),
                                    child: Column(
                                      children: [
                                        Text(
                                          'You have attended 93 out of 123 classes',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff052250),
                                              fontSize: 17),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Well Done! you have minimum attendance',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff052250),
                                              fontSize: 17),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                      physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: List.generate(_subjects.length, (index) {
                        return Card(
                          color: color1,
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: color2,
                                child: Text(
                                  '81%',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: color1,
                                      fontSize: 25),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //Icon(Icons.article_outlined,size: 100,),
                              //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                              Text(
                                _subjects[index],
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> _subjects = ['MLA', 'ICS', 'BAI', 'STQA', 'SDM'];
