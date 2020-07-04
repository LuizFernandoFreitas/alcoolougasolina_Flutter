import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  // Se a tela estiver carregando, temos que exibir o carregando
  var busy = false;
  // Inverte as cores
  var invert = false;
  // Função que o botão vai executar
  Function func;
  // Texto que teremos no botão
  var text = "";

  LoadingButton({
    @required this.busy,
    @required this.func,
    @required this.invert,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return busy
        ? Container(
            alignment: Alignment.center,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        : Container(
            margin: EdgeInsets.all(30),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: invert
                  ? Theme.of(context).primaryColor
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(60),
            ),
            child: FlatButton(
              child: Text(
                text,
                style: TextStyle(
                  // Usa a cor do tema principal
                  color: invert ? Colors.white : Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontFamily: "BigShouldersDisplay",
                ),
              ),
              // Quando se criar uma função desta forma, informamos que ela é anônima
              // Quando passamos uma função sem os parenteses, informa que estamos apenas passando a mesmo como parametro
              onPressed: func,
            ),
          );
  }
}
