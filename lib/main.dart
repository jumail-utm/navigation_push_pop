import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'navigation push and pop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      onGenerateRoute: generateRoute,
    ));

Route<dynamic> generateRoute(settings) {
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
        title: Text('Push and Pop Example'),
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
              caption: 'push (to open next screen)',
              onPressed: () => Navigator.pushNamed(context, nextRoute),
            ),
          _Button(
            showPrevious: true,
            caption: 'pop (to close this screen)',
            onPressed: () => Navigator.pop(context),
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
            Text(caption),
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
