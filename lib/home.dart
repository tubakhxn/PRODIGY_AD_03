import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int seconds= 0, minutes = 0 ,hours = 0;
  String digitSeconds ="00",digitMinutes ="00", digitHours ="00";
  Timer? timer;
  bool started =false;
  List laps =[];

  void stop(){
    timer!.cancel();
    setState(() {
      started =false;
    }); 
  }

  void reset(){
    timer!.cancel();
    setState(() {
      seconds =0;
      minutes =0;
      hours =0;

      digitSeconds ="00";
      digitMinutes ="00";
      digitHours ="00";

      started =false;
      laps =[];
    });
  }

  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start(){
    started =true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      int localSecods = seconds+1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSecods >59){
        localMinutes ++;
        localSecods =0;
        if(localMinutes > 59){
          localHours ++;
          localMinutes=0;
        }
      }
    setState(() {
      hours =localHours;
      minutes =localMinutes;
      seconds =localSecods;
      digitSeconds =(seconds >=10)? "$seconds" :"0$seconds";
      digitHours =(hours >=10)? "$hours" :"0$hours";
      digitMinutes =(minutes >=10)? "$minutes" :"0$minutes";
    });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff07af7b),
      body: Container(
        constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/images/background.png"), 
                fit: BoxFit.cover),
              ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const Center(
              //  child: Text("Stop Watch",
              //  style: TextStyle(
              //    fontSize: 30,
              //    fontWeight: FontWeight.w700,
              //    color: Color(0xff3355ef),
              //  ),),
              //),
              const SizedBox(height: 30.0,),
               Center(
                child: Text("$digitHours:$digitMinutes:$digitSeconds",
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff3355ef),
                ),)),
                //const SizedBox(height: 10.0,),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xff0B1B5B),
                ),
                child:(laps.isNotEmpty)? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: laps.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom:10.0),
                        child: Container(
                          width: 120,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding:  const EdgeInsets.only(bottom:10.0, left: 10),
                            child: ListTile(
                              title: Text("Lap Number : ${index+1}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),),
                              subtitle:Text("${laps[index]}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,color: Colors.white,), 
                                onPressed: () { 
                                  if (index >= 0 && index < laps.length) {
                                    setState(() {
                                    laps.removeAt(index);
                                  });
                                 }
                                 },)
                            ),
                          ),
                        ),
                      );
                    }
                    ),
                ) : Center(
                  child: Image.asset("assets/images/timee.png"))
              ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      (!started)? start(): stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child:  Text((!started)? "Start": "pause",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),),)),
                IconButton(
                  onPressed: (){
                    addLaps();
                  }, 
                  icon: const Icon(Icons.flag_rounded,color: Colors.white,size: 28,)),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: (){
                      reset();
                    },
                    fillColor: Colors.white,
                    shape: const StadiumBorder(),
                    child: const Text("Reset",
                    style: TextStyle(
                      color: Color(0xff3355ef),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),),)),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}