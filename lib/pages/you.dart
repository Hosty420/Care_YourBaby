import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class You extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageYou();
}

class ManageYou extends State<You> {
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
            icon: Icon(Icons.pregnant_woman_sharp),
          ),
          automaticallyImplyLeading: false,
          //iconTheme: Icons.question_answer_outlined,
          title: const Text('CUIDADO ESTÉTICO'),
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
              title: Text('HABLEMOS DEL CUIDADO DE LA PIEL',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Veámos lo que dice una experta acerca del cuidado de la piel'),
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
              title: Text('¿CÓMO PREVENIR LAS ESTRÍAS DURANTE EL EMBARAZO?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '“Las estrías son unas líneas que aparecen en determinadas partes del cuerpo, '
                  'tanto de la mujer como del hombre, como consecuencia de la rotura de las fibras'
                  ' de colágeno y elastina que tenemos en la piel.'
                  'En el caso de las mujeres embarazadas, las estrías suelen aparecer a menudo en los pechos y en '
                  'el abdomen debido al aumento de tamaño del útero a partir del segundo trimestre de gestación..'),
            ),
            SizedBox(height: 10.0),
            Positioned.fill(
              child: Image.asset(
                'assets/estriasEmbarazo.jpg',
              ),
            ),
            ListTile(
              title: Text(
                  'Bebe abundante agua para mantener la piel hidratada desde el interior',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  ' Mínimo dos litros de agua, infusiones o zumos naturales al día.'),
            ),
            ListTile(
              title: Text(
                  'Haz ejercicio de forma regular porque favorece la circulación y estimula la producción de colágeno.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  ' Tu piel se volverá más elástica si mejora su tono muscular.'),
            ),
            ListTile(
              title: Text('Hidrata la piel',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Las pieles secas tienen mucha más tendencia a que aparezcan estrías. Mantén tu'
                  ' piel hidratada y nutrida aplicándote una buena crema o aceite especial para'
                  ' prevenir estrías durante el embarazo. Las cremas antiestrías tienen entre sus '
                  'componentes sustancias que ayudan a la formación de colágeno a la vez que '
                  'hidratan en profundidad y reparan los cambios que ya ha sufrido. Aplícala desde'
                  ' el primer día y continúa hasta dos meses después del parto. Los dos últimos'
                  ' meses, aplícala dos veces al día dando un suave masaje. Tu piel tendrá mejor '
                  'aspecto, estará más suave y reducirás además los picores típicos que produce el'
                  ' estiramiento de tu piel.'),
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
              title: Text('¿EL ACEITE ES PREVENTIVO PARA EVITAR LAS ESTRÍAS?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Según la dermatóloga Paula Sanchez de San Pablo, Brasil, aunque la práctica no '
                  'provoque ningún tipo de trastorno, tampoco significa que sea efectiva. Esto se '
                  'debe a que las estrías se producen cuando las fibras de la piel se rompen lo que'
                  ' se evita cuando la piel está elástica e hidratada. Tampoco sucede cuando se '
                  'mantienen hábitos saludables, pues el peso es siempre el mismo.'
                  'Lo que se usa, por lo general, y que es recomendado por todos los especialistas'
                  ' en piel son cremas hidratantes en lugar de aceites.'
                  'Al respecto, la doctora Sanchez nos dice que «los aceites dejan la piel más suave y causan una '
                  'falsa sensación. Pero no hidratan de hecho».'),
            ),
            SizedBox(height: 10.0),
            Positioned.fill(
              child: Image.asset(
                'assets/cremasHidratantes.jpg',
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
