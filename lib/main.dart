import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'navigation push and pop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      onGenerateRoute: generateRoute,
    ));

Route<dynamic> generateRoute(settings) {
  // print('in Router: ${settings.arguments}');

  switch (settings.name) {
    case '/':
    case '/screen1':
      return MaterialPageRoute(
        builder: (_) => Screen(
          title: 'Screen 1',
          nextRoute: '/screen2',
        ),
      );

    case '/screen2':
      return MaterialPageRoute(
        builder: (_) => Screen(
          title: 'Screen 2',
          nextRoute: '/screen3',
        ),
      );

    case '/screen3':
      return MaterialPageRoute(
        builder: (_) => Screen(
          title: 'Screen 3',
          nextRoute: null,
        ),
      );
    case '/replacement':
      return MaterialPageRoute(
        builder: (_) => Screen(
          title: 'Replacement',
          nextRoute: null,
        ),
      );
  }

  return null;
}

class Screen extends StatelessWidget {
  final String title;
  final String nextRoute;

  Screen({this.title, this.nextRoute});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More push operations'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Center(
              child: Text(title, style: TextStyle(fontSize: 50)),
            ),
          ),
          if (nextRoute != null)
            _Button(
              showNext: true,
              caption: 'pushNamed()',
              onPressed: () async {
                final result = await Navigator.pushNamed(context, nextRoute,
                    arguments: 'args sent from $title pushNamed');

                print('In "$title pushNamed", receiving "$result"');
              },
            ),
          _Button(
            showNext: true,
            caption: 'pushReplacementNamed()',
            onPressed: () async {
              final result = await Navigator.pushReplacementNamed(
                context,
                '/replacement',
                arguments: 'args sent from $title pushReplacementNamed',
                result: 'result from $title',
              );

              print('In "$title pushReplacementNamed", receiving "$result"');
            },
          ),
          _Button(
            showNext: true,
            caption: 'popAndPushNamed()',
            onPressed: () async {
              final result = await Navigator.popAndPushNamed(
                context,
                '/replacement',
                arguments: 'args sent from $title pushReplacementNamed',
                result: 'result from $title',
              );

              print('In "$title popAnPushNamed", receiving "$result"');
            },
          ),
          _Button(
            showNext: true,
            caption: 'pushNamedAndRemoveUntil()',
            onPressed: () async {
              final result = await Navigator.pushNamedAndRemoveUntil(
                context,
                '/replacement',
                ModalRoute.withName('/screen1'),
                arguments: 'args sent from $title pushNamedAndRemoveUntil',
              );

              print('In "$title pushNamedAndRemoveUntil", receiving "$result"');
            },
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String caption;
  final Function onPressed;
  final bool showPrevious;
  final bool showNext;

  _Button({this.caption, this.onPressed, this.showPrevious, this.showNext});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FloatingActionButton.extended(
        heroTag: null,
        onPressed: onPressed,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              showPrevious != null ? Icons.navigate_before : null,
              size: 50,
            ),
            SizedBox(
                width: 220,
                child: Text(
                  caption,
                  textAlign: TextAlign.center,
                )),
            Icon(
              showNext != null ? Icons.navigate_next : null,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
