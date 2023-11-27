import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../repo/shared_preference_manager.dart';

class RemarkScreen extends StatefulWidget {
  const RemarkScreen({Key? key}) : super(key: key);

  @override
  State<RemarkScreen> createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  TextEditingController _etcController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    _etcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/wave/beige_wave2.png'),
              Image.asset(
                    'assets/images/beige/remark/header.png',
                    height: MediaQuery.of(context).size.height * 0.1),

            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextButton(
                    child: Image.asset(
                        'assets/images/beige/remark/choice1.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.45),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.save);
                      _prefsManager.saveRemark("-", "-");
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        child: Image.asset(
                            'assets/images/beige/remark/choice2.png',
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.25),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.save);
                          _prefsManager.saveRemark("poor condition", "-");

                        },
                      ),TextButton(
                        child: Image.asset(
                            'assets/images/beige/remark/choice3.png',
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.25),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.save);
                          _prefsManager.saveRemark("external factors", "-");

                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Image.asset(
                            'assets/images/beige/remark/choice4.png',
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.25),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.save);
                          _prefsManager.saveRemark("Device error", "-");

                        },
                      ),
                      TextButton(
                        child: Image.asset(
                            'assets/images/beige/remark/choice5.png',
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.25),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.save);
                          _prefsManager.saveRemark("Cross-Culture Kid", "-");

                        },
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextField(
                  decoration: InputDecoration(hintText: '기타(직접 입력)') ,
                    style : TextStyle(fontSize:25),
                  controller: _etcController,

                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.save);
                _prefsManager.saveRemark("-", _etcController.text);

              }, child: Text('확인', style: TextStyle(fontSize: 25)))
            ],
          )

        ],
      ),
    );
  }
}
