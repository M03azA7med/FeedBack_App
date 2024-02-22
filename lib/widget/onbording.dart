import 'package:feedback/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import 'const.dart';
class boardingModel
{
  final String image;
  final String title;
  final String body;

  boardingModel({
    required this.image,
    required this.title,
    required this.body,
  });


}
class onbording extends StatefulWidget {
  const onbording({super.key});
  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  List<boardingModel> boarding=
  [
    boardingModel(
      image:'assets/images/feedback.png',
      body: 'Your opinion is important to us',
      title: 'Feedback',
    ),
    boardingModel(
      image:'assets/images/feedback.png',
      body: 'Express your opinion very frankly',
      title: 'Feedback',
    ),


  ];

  var boardingController=PageController();
  bool islast=false;

  void submit()
  {
      if(islast) {
        navigateTo(context, loginscreen());
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index) => onBoardingitems(boarding[index]),
                itemCount: 2,
                controller: boardingController,
                onPageChanged: (int index){
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      islast=true;
                    });
                  }else
                  {
                    setState(() {
                      islast=false;
                    });
                  }
                },

              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardingController, count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.amber,
                    expansionFactor: 4,
                    spacing: 5.0,

                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){

                  if(islast)
                  {
                    submit();
                  }else{
                    boardingController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        )
                        , curve: Curves.fastLinearToSlowEaseIn
                    );
                  }

                },
                  child: Icon(Icons.next_plan,),backgroundColor:Colors.amber ,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
