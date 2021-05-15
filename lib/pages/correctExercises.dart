import 'package:care_yourbaby/pages/home.dart';
import 'package:care_yourbaby/pages/training.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppropiateE extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppropiateExercise();
}

class AppropiateExercise extends State<AppropiateE> {
  VideoPlayerController _videoController;
  VideoPlayerController _audioController;
  VideoPlayerController _specialistVideo;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('assets/videoEjerciciosGluteosPiernas.mp4')
          // **When the controllers change, call setState() to rebuild widget.**
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize();
    _specialistVideo = VideoPlayerController.asset(
        'assets/EjerciciosRecomenDableDuranteEmbarazo.mp4')
      // **When the controllers change, call setState() to rebuild widget.**
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
    _audioController = VideoPlayerController.network(
        'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ConvexAppExample()));
            },
            icon: Icon(Icons.sports_volleyball_outlined),
          ),
          automaticallyImplyLeading: false,
          //iconTheme: Icons.question_answer_outlined,
          title: const Text('ENTRENAMIENTO'),
          backgroundColor: Color.fromRGBO(151, 84, 247, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_adviceOne(), _adviceTwo()],
          ),
        ));
  }

  Widget _adviceOne() {
    return Center(
      child: _videoController.value.isInitialized
          ? _buildVideoPlayerUI()
          : const CircularProgressIndicator(),
    );
  }

  Widget _adviceTwo() {
    return Center(
      child: _videoController.value.isInitialized
          ? _buildVideoPlayerUI2()
          : const CircularProgressIndicator(),
    );
  }

  Widget _buildVideoPlayerUI() {
    return Container(
      margin: EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      child: Card(
        color: Color.fromRGBO(239, 236, 243, 1),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('TONIFICAR GLUTEOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Estos son nuestros ejercicios recomendados para glúteos son ejercicios en '
                  'casa para embarazadas que pueden realizarse cómodamente.'),
            ),
            ListTile(
              title: Text('1) Sentadillas',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Con el siguiente ejercicio debes estar acostada de forma lateral, recuesta la cabeza '
                  ' sobre el brazo que da al suelo y la pierna del mismo lado debe estar un paso delante'
                  'de la otra, ambas piernas deben estar bien estiradas, la pierna que queda delante'
                  ' debes elevarla y luego bajarla sin que toque el suelo.'),
            ),
            SizedBox(height: 10.0),
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            Text(
                '${_videoController.value.position} / ${_videoController.value.duration}'),
            VideoProgressIndicator(_videoController, allowScrubbing: true),
            SizedBox(
              height: 5.0,
            ),
            ElevatedButton.icon(
              onPressed: () => _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play(),
              icon: Icon(_videoController.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow),
              label: Text(
                  _videoController.value.isPlaying ? 'Pausar' : 'Reproducir'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerUI2() {
    return Container(
      margin: EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      child: Card(
        color: Color.fromRGBO(239, 236, 243, 1),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('HABLANDO CON LOS ESPECIALISTAS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Aquí una pequeña entrevista con el especialista de entrenamiento en estado'
                  ' pretanal.'),
            ),
            SizedBox(height: 10.0),
            AspectRatio(
              aspectRatio: _specialistVideo.value.aspectRatio,
              child: VideoPlayer(_specialistVideo),
            ),
            Text(
                '${_specialistVideo.value.position} / ${_specialistVideo.value.duration}'),
            VideoProgressIndicator(_specialistVideo, allowScrubbing: true),
            ElevatedButton.icon(
              onPressed: () => _specialistVideo.value.isPlaying
                  ? _specialistVideo.pause()
                  : _specialistVideo.play(),
              icon: Icon(_specialistVideo.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow),
              label: Text(
                  _specialistVideo.value.isPlaying ? 'Pausar' : 'Reproducir'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.purple.shade400;
    }
    return Color.fromRGBO(151, 84, 247, 1);
  }
}
