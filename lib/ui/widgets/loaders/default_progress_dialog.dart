import 'package:flutter/material.dart';

Widget DefaultCircularProgress({String texto = "Cargando..."}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.indigo,
        ),
        Text(
          texto,
          style: const TextStyle(color: Colors.indigo),
        )
      ],
    ),
  );
}
