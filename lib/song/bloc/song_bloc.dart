import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record/record.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc() : super(SongInitial()) {
    on<SongListen>((songCambiar));
  }
  void songCambiar(SongEvent event, Emitter emit) async {
    emit(SongLoading());
    var result = await getSong();
    if (result == null) {
      emit(SongErrorState(errorMsg: 'Error'));
    } else {
      print(result['title']);
      print(result['artist']);
      emit(SongSuccess(mapa: result));
    }
  }
}

Future getSong() async {
  Duration t = Duration(seconds: 10);
  Record record = Record();
  try {
    bool result = await record.hasPermission();
    await record.start(
      encoder: AudioEncoder.AAC, // by default
      bitRate: 128000, // by default
      samplingRate: 44100, // by default
    );
    await Future.delayed(t);
    var recorded = await record.stop();
    if (recorded == null) {
      return;
    }

    //final bytes = recorded2.readAsBytesSync();
    var bytes = File(recorded).readAsBytesSync();
    String data64 = base64Encode(bytes);

    http.Response res =
        await http.post(Uri.parse('https://api.audd.io/%22'), body: {
      'audio': data64,
      'return': 'apple_music,spotify',
      'api_token': '52c5d26c81a29cf3c3d007f668bc7934'
    });
    //log(jsonDecode(res.body).toString());
    if (res.statusCode == HttpStatus.ok) {
      return jsonDecode(res.body)['result'];
    }
  } catch (e) {
    print(e);
  }
}
