
import 'package:flutter/material.dart';
import 'package:taskk2/Models/constants.dart';
import 'package:taskk2/ul/home.dart';
class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.primaryColor.withOpacity(.5),
        child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo.jpeg'),
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap:() {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                  },

                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration:  BoxDecoration(
                      color: myConstants.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text('Get Started',style: TextStyle(color: Colors.white, fontSize: 17),),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
