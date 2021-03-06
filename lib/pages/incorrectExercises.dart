import 'package:care_yourbaby/pages/home.dart';
import 'package:care_yourbaby/pages/training.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class InappropiateE extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InappropiateExercise();
}

class InappropiateExercise extends State<InappropiateE> {
  VideoPlayerController _videoController;
  VideoPlayerController _audioController;
  VideoPlayerController _specialistVideo;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        'assets/EjerciciosNoRecomenDableDuranteEmbarazo.mp4')
      // **When the controllers change, call setState() to rebuild widget.**
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
    _specialistVideo = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
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
            children: <Widget>[_adviceOne(), _adviceTwo(), _otherAdvices()],
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
              title: Text('ABDOMINALES TIPO "CRUNCH"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Tambi??n hay que tener mucho cuidado con la pr??ctica de los abdominales '
                  'tradicionales,  tipo ???crunch???. Est??n contraindicados. Deberemos  tener '
                  'cuidado con las incorporaciones, haci??ndolas de costado. Si no, se provocar?? '
                  'm??s divisi??n de los rectos abdominales, y se acent??a la di??stasis abdominal.'),
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
              title: Text('NO HIDRATARSE',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '???La hidrataci??n es sumamente importante. Si se llega a tener sed, ya ser?? '
                  'tarde. A nivel corporal ha comenzado una deshidrataci??n???, afirma Villar.'),
            ),
            SizedBox(height: 10.0),
            Positioned.fill(
              child: Image.asset(
                'assets/hidratacion.jpg',
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

  Widget _otherAdvices() {
    return Container(
      margin: EdgeInsets.only(left: 13.0, right: 13.0, top: 13.0),
      child: Card(
        color: Color.fromRGBO(239, 236, 243, 1),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('OTROS DEPORTES INADECUADOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/peligro.jpg',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '- Deportes con riesgo de ca??da',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Text(
              '- Deportes que implican cambio de altitud',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.right,
            ),
            Text(
              '- Ejercicio boca arriba durante largo tiempo',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.left,
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
