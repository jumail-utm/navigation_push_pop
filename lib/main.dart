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
    return WillPopScope(
      onWillPop: () => Future.value(Navigator.canPop(context)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('pop() vs maybePop()'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Center(
                child: Text(title, style: TextStyle(fontSize: 50)),
              ),
            ),
            if (nextRoute != null)
              _Button(
                showNext: true,
                caption: 'push()',
                onPressed: () => Navigator.pushNamed(context, nextRoute),
              ),
            _Button(
              showPrevious: true,
              caption: 'pop()',
              onPressed: () => Navigator.pop(context),
            ),
            _Button(
              showPrevious: true,
              caption: 'maybePop()',
              onPressed: () => Navigator.maybePop(context),
            ),
            _Button(
              showPrevious: true,
              caption: 'test canPop() before pop()',
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.maybePop(context);
                }
              },
            ),
            Center(
                child: Text('canPop(): ${Navigator.canPop(context).toString()}',
                    style: TextStyle(fontSize: 25))),
          ],
        ),
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
                width: 200,
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
