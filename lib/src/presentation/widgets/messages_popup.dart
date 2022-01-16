import 'package:flutter/material.dart';

messageOK(
    {required BuildContext context,
    required String msg,
    final VoidCallback? action}) {
  VoidCallback _action = () => Navigator.of(context).pop();

  if (action != null) {
    _action = action;
  }
  final widthScreen = MediaQuery.of(context).size.width;

  Color colorHeader = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.done,
              size: 50.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 3.0),
              shape: BoxShape.circle,
              color: Color(0XFFF8FDFF),
            ))),
    content: Container(
      padding: const EdgeInsets.all(20.0),
      alignment: AlignmentDirectional.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Center(
          child: Text(
        msg,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      )),
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      TextButton(
          onPressed: _action,
          child: Text('Aceptar',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'PoppinsSemiBold',
                  fontSize: 20.0)))
    ],
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

messageThowOK(
    {required BuildContext context,
    required String msg,
    required final VoidCallback? action,
    required final VoidCallback? secondAction}) {
  final widthScreen = MediaQuery.of(context).size.width;

  Color colorHeader = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170.0,
        width: widthScreen * .90,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.done,
              size: 50.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 3.0),
              shape: BoxShape.circle,
              color: Color(0XFFF8FDFF),
            ))),
    content: Container(
      padding: const EdgeInsets.all(20.0),
      alignment: AlignmentDirectional.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Center(
          child: Text(
        msg,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      )),
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      TextButton(
          onPressed: action,
          child: Text('Salir',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'PoppinsSemiBold',
                  fontSize: 20.0))),
      const Expanded(child: SizedBox()),
      TextButton(
          onPressed: secondAction,
          child: Text('Seguir Creando',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'PoppinsSemiBold',
                  fontSize: 20.0)))
    ],
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
