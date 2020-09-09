import 'dart:math';

import 'package:flutter/material.dart';

class ReportsWidget extends StatefulWidget {
  ReportsWidget({@required this.colorApp});

  final Color colorApp;

  @override
  _ReportsWidgetState createState() => _ReportsWidgetState();
}

class _ReportsWidgetState extends State<ReportsWidget> {
  bool _isBeingGenerated;
  bool _isButtonEnabled;
  Color _lighterColorApp;

  @override
  void initState() {
    super.initState();
    _isBeingGenerated = false;
    _isButtonEnabled = true;

    var hsl = HSLColor.fromColor(widget.colorApp);
    _lighterColorApp =
        hsl.withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0)).toColor();
  }

  Future<void> _generateReport() async {
    setState(() {
      _isBeingGenerated = true;
      _isButtonEnabled = false;
    });
    await _postGenerateReport();
    bool reportGenerated = false;

    do {
      reportGenerated = await _getReportStatus();
      if (reportGenerated) {
        setState(() {
          _isBeingGenerated = false;
          _isButtonEnabled = true;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("Operation completed"),
              content: Text("Report generated successfully."),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'OK',
                      style: TextStyle(color: widget.colorApp),
                    )),
              ]),
        );
      }
      await Future.delayed(const Duration(seconds: 10));
    } while (reportGenerated == false);
  }

  Future<void> _postGenerateReport() async {
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  Future<bool> _getReportStatus() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return Random().nextBool();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reports Generator")),
        body: Align(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _generatingIndicator(_isBeingGenerated),
              SizedBox(
                width: 200,
                child: RaisedButton(
                    onPressed: _isButtonEnabled ? _generateReport : null,
                    child: Text("Generate report",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                    color: widget.colorApp,
                    disabledColor: _lighterColorApp,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            ])));
  }
}

Widget _generatingIndicator(bool load) {
  return load
      ? Column(children: [
          new CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Please wait..."),
          SizedBox(height: 30)
        ])
      : new Container();
}
