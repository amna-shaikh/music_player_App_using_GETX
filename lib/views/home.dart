import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player_app/consts/colors.dart';
import 'package:music_player_app/consts/textstyle.dart';
import 'package:music_player_app/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/player_controller.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgDarkcolor,
        leading: Icon(Icons.sort_rounded , color: whitecolor,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search , color: whitecolor,))
        ],
        title: Text('Beats' ,
        style: textstyle()
        ),
      ),
      body:FutureBuilder<List<SongModel>>(
        future: controller.audioquery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL
        ),
        builder: (BuildContext context , snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.data!.isEmpty) {
return Text("No songs found" , style: textstyle(),);
          }
          else {
            return  Padding(padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context , int index){
                    return Container(
                      margin: EdgeInsets.only(bottom : 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(
                          ()=> ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          tileColor: bgcolor,
                          title: Text(snapshot.data![index].displayNameWOExt , style: textstyle(size: 15)),
                          subtitle: Text(snapshot.data![index].artist! , style: textstyle(size: 12)),
                          leading:QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.AUDIO, nullArtworkWidget:  Icon(Icons.music_note , color: Colors.white, size: 32),),
                          trailing:controller.playindex == index && controller.isplaying.value?  Icon(Icons.play_arrow , color: Colors.white, size: 26) : null,
                         onTap: (){
                            Get.to(() => playerScreen(snapshot.data!),
                                transition :Transition.upToDown,

                            );

                            controller.playsong(snapshot.data![index].uri , index);
                         },

                        ),
                      ),
                    );
                  }
              ),

            );
          }
        },
      )
    );
  }
}
