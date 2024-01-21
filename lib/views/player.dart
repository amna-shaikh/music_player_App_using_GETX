import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player_app/consts/colors.dart';
import 'package:music_player_app/consts/textstyle.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/player_controller.dart';

class playerScreen extends StatelessWidget {
  final List<SongModel> data ;
  const playerScreen( this.data);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Obx(
          ()=> Expanded(child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

              ),
             alignment: Alignment.center,
              child:QueryArtworkWidget(id: data[controller.playindex.value].id, type: ArtworkType.AUDIO,
              artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget:  Icon(Icons.music_note , color: Colors.white, size: 48,),
              )

            )),
          ),
          SizedBox(height: 12,),
          Expanded(child: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              )
            ),
child: Obx(
  () =>   Column(

    children: [

      Text(data[controller.playindex.value].displayNameWOExt ,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,

        style: textstyle(family: bold , size: 24 , color: bgcolor),),

      SizedBox(height: 12,),

      Text(data[controller.playindex.value].artist.toString() ,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: textstyle(family: bold , size: 20 , color: bgcolor),),

      SizedBox(height: 12,),

      Obx(

        () => Row(

          children: [

            Text(controller.position.value, style: textstyle( color: bgcolor),),

            Expanded(child: Slider(

              inactiveColor: Colors.deepPurple,

                thumbColor: Colors.purpleAccent,

                activeColor: Colors.purple,

  min: Duration(seconds: 0).inSeconds.toDouble(),

  max: controller.max.value,

                value: controller.value.value,



                onChanged: (newValue){

                controller.changeDurationToSeconds(newValue.toInt());

                newValue = newValue;





            })),

            Text(controller.duration.value , style: textstyle( color: bgcolor),),

          ],

        ),

      ),



      SizedBox(height: 12,),

      Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          IconButton(onPressed: (){

            controller.playsong(data[controller.playindex.value - 1].uri, controller.playindex.value - 1);
          }, icon: Icon(Icons.skip_previous_rounded , size: 40,color: bgcolor,)),

          Obx(

              () => CircleAvatar(

              radius: 35,

              backgroundColor: bgcolor,

                child: Transform.scale(

                  scale: 2.5,

                    child:



                    IconButton(onPressed: (){

                      if(controller.isplaying.value){

  controller.audioplayer.pause();

  controller.isplaying(false);

                      }

                      else {

                        controller.audioplayer.play();

                        controller.isplaying(true);

                      }

                    }, icon: controller.isplaying.value?

                    Icon(Icons.pause , color:Colors.white,)

                     :Icon(Icons.play_arrow_rounded , color:Colors.white,),



                    ))),

          ),

          IconButton(onPressed: (){

            controller.playsong(data[controller.playindex.value + 1].uri, controller.playindex.value + 1);

          }, icon: Icon(Icons.skip_next_rounded , size: 40, color: bgcolor,)),

        ],

      )

    ],

  ),
),

          )),
        ],
      ),


      ),
    );
  }
}
