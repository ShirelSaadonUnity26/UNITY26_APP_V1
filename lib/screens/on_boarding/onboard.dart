import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity26_app_v1/screens/on_boarding/onboard_model.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/screens/otp/otp_screen.dart';


class OnBoard extends StatefulWidget {

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool isVisible = true;
  bool flag =false;
  int currentIndex = 0;
  String x='הרשמו עכשיו';
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/logo.png',
      text: "ברוכים הבאים ",
      desc:
      ".מהיום ניתן לקבל סיוע בכל מקרה חירום מאנשים שנמצאים בסביבתך",
      bg: kbackground,
      button: kcolorapp,

    ),
    OnboardModel(
      img: 'assets/images/splash1.png',
      text: "התהליך הוא פשוט ",
      desc:
      "נרשמים לאפליקציה, וכעת בכל מקרה חירום בין אם מדובר בסכנת חיים או שאתם רק זקוקים להטעין את המצבר של הרכב",
      bg: kbackground,
      button: kcolorapp,
    ),
    OnboardModel(
      img: 'assets/images/splash2.png',
      text: "?איך זה עובד",
      desc:
      " בלחיצת כפתור , האפליקציה מאתרת בזמן אמת אזרחים ואנשי מקצוע באיזורך שיכולים להגיע ולסייע במהירות",
      bg: kbackground,
      button: kcolorapp,
    ),



    OnboardModel(
      img: 'assets/images/instagram_profile_image.png',
      text:"הצטרף אלינו",
      desc:
      " במידה ואתה מעוניין להצטרף למערך הסיוע שלנו - תוכל לציין זאת בתהליך הרישום ולהיות חלק מנותני הסיוע!",
      bg: kbackground,
      button: kcolorapp,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: kbackground ,
      appBar: AppBar(
        backgroundColor: kbackground ,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OtpScreen()));


              //Navigator.pushNamed(context, OtpScreen.routeName);

            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: kblack,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(

            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  SizedBox(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? kSecondaryColor
                                      : kcolorapp,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: kblack,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Montserrat',
                      color:kblack
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                        if (index == screens.length - 1 || index == 0) {
                          isVisible=true;
                          x="הרשמו עכשיו";
                          await _storeOnboardInfo();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => OtpScreen()));
                          //Navigator.pushNamed(context, OtpScreen.routeName);
                        }
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.bounceIn,
                        );
                        x="הבא";

                        if (index==screens.length - 2){
                          flag=true;
                          _storeOnboardInfo();
                           x="הרשמו לאפליקציה";
                        }
                      flag=false;
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        );
                    },
                      child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color:  kcolorapp ,
                          borderRadius: BorderRadius.circular(15.0)),
                      child:
                      Row(mainAxisSize: MainAxisSize.min,
                        children:
                      [
                            Text(
                              x.toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: kblack
                              ),
                            ),

                        const SizedBox(
                          width: 15.0,
                        ),
                        const Icon(
                          Icons.arrow_forward_sharp,

                        ),

                      ],

                      ),



                    )
                      )
                  ),
                    if (isVisible)
                    InkWell(
                        onTap: () async {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn,
                          );
                          isVisible=false;
                          x='הבא';
                        },


              child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          decoration: BoxDecoration(
                              color: kbackground,
                              borderRadius: BorderRadius.circular(1.0)),

                          child:
                          Row(mainAxisSize: MainAxisSize.min,textDirection: TextDirection.rtl,
                            children: const <Widget>[
                              Text(
                                'למידע נוסף',

                                style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                ),
                              ),

                            ],
                          ),


                        )
              )


                ],

              );

            }),

      ),

    );

  }
  Widget _loginAccountLabel() {
    return InkWell(
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(


          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(

              'למידע נוסף ',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'לחץ כאן',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),

            ),
          ],
        ),
      ),
    );
  }
int isLastPage(bool flag) {
    if(flag){
      return 1;
    }else{
      return 0;
    }



  }
}