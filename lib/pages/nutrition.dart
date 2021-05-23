import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Nutrition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageNutrition();
}

class ManageNutrition extends State<Nutrition> {
  VideoPlayerController _videoController;
  VideoPlayerController _audioController;
  VideoPlayerController _specialistVideo;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('assets/riesgosComerCarneCruda.mp4')
          // **When the controllers change, call setState() to rebuild widget.**
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize();
    _specialistVideo =
        VideoPlayerController.asset('assets/alimentacionEmbarazo.mp4')
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
            onPressed: () {},
            icon: Icon(Icons.food_bank_rounded),
          ),
          automaticallyImplyLeading: false,
          //iconTheme: Icons.question_answer_outlined,
          title: const Text('NUTRICIÓN'),
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
              title: Text('CONSUME LA CARNE BIEN HECHA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Cuando vayas a comer una hamburguesa y el camarero te pregunte: ´¿Al punto o'
                  ' hecha?´, responde sin dudar: ´Bien hecha´. La carne cruda o poco cocinada puede'
                  ' contener la bacteria Listeria, además de producir toxoplasmosis. ´Si la infección '
                  'de toxoplasmosis tiene lugar por primera vez durante la gestación, puede transmitirla'
                  ' al feto a través de la placenta, poniendo en peligro su salud, e incluso su vida, '
                  'afirma la especialista en Nutrición Marta González Caballero.'
                  ' Para evitarlo, debes cocinar siempre la carne por encima de 65ºC.'),
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
              title: Text('¿CÓMO SACIAR LOS ANTOJOS DE MANERA SALUDABLE?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '“Los antojos en el embarazo son de lo más comunes, y no está mal satisfacerlos,'
                  ' pero siempre hay que hacer con consciencia saludable.'),
            ),
            SizedBox(height: 10.0),
            Positioned.fill(
              child: Image.asset(
                'assets/antojos.jpg',
              ),
            ),
            ListTile(
              title: Text('1. Prepara tu despensa',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Lo primero es tomar acciones preventivas, para ello te recomendamos colocar alimentos y '
                  'snacks saludables en tu despensa. Como frutas, avena, frutos secos, frutos rojos, chocolate '
                  'oscuro, leche descremada... Pero por sobre todo, elimina las tentaciones y los alimentos '
                  'que te pueden hacer daño, como las grasas y las frituras.'),
            ),
            ListTile(
              title: Text('2. Asiste a un nutricionista',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Si tienes muchas dudas sobre qué puedes comer y qué debes evitar, entonces'
                  ' asiste a un nutricionista para que te dé una guía sencilla y satisfactoria'
                  ' para calmar tus antojos de forma saludable.'),
            ),
            ListTile(
              title: Text('3. Busca alternativas',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'A pesar de que tu cuerpo "te pida" ciertos alimentos, no es necesario que los cumplas al'
                  ' pie del antojo. Puedes engañar a tu cerebro con opciones más saludables e igual de deliciosas.'),
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
              title: Text(
                  'LA IMPORTANCIA DE LA BUENA ALIMENTACIÓN EN EL EMBARAZO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'La espera y la llegada de un bebé es una oportunidad para repensar la'
                  ' alimentación de toda la familia y comer mejor. Te invitamos a conocer cómo'
                  'con el siguiente vídeo'),
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
