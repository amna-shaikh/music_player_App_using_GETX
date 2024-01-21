import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{
  final audioquery = OnAudioQuery();
  final audioplayer = AudioPlayer();
    var playindex = 0.obs;
    var isplaying = false.obs;
    var duration = "".obs;
    var position = "".obs;
    var max=0.0.obs;
  var value=0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    permissionhandler();
  }
  changeDurationToSeconds(seconds){
    var duration = Duration(seconds: seconds);
    audioplayer.seek(duration);
  }
  updateposition (){
    audioplayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioplayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p!.inSeconds.toDouble();
    });

  }
  playsong(String? uri , index){
    playindex.value = index;
    try{
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
      isplaying(true);
      updateposition();
    } catch(e) {
     print(e.toString());
    }

  }

   permissionhandler () async {

    var perm = await Permission.storage.request();
    if(perm.isGranted){
      /*return audioquery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL
      );*/
    }
else{
  permissionhandler();
    }
  }







}