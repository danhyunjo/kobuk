import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class ChildReview extends StatefulWidget {
  const ChildReview({Key? key}) : super(key: key);

  @override
  State<ChildReview> createState() => _ChildReviewState();
}

class _ChildReviewState extends State<ChildReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Image.asset('assets/images/wave/beige_wave2.png'),
            Positioned( child: Image.asset('assets/images/beige/child_review/header.png',width:MediaQuery.of(context).size.height*0.3),
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/beige/child_review/choice1.png', width:MediaQuery.of(context).size.width*0.4,height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){},
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.08,),
            TextButton(
            child : Image.asset('assets/images/beige/child_review/choice2.png', width:MediaQuery.of(context).size.width*0.4,height: MediaQuery.of(context).size.height*0.35),
            onPressed: (){},
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Center(child:Image.asset('assets/images/beige/child_review/footer.png',width:MediaQuery.of(context).size.height*0.6) ,)


      ],),
    );
  }
}
