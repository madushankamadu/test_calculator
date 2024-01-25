// ignore_for_file: unnecessary_const

import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(btnText){
    setState(() {
      if (btnText == 'CE'){
        equation = "0";
        result = "0";
      }else if (btnText == '⌫'){
        equation = equation.substring(0,equation.length -1);
        if (equation == ""){
          equation = "0";
        }
      }else if (btnText == '='){
        expression = equation;
        expression = expression.replaceAll('x', "*");
        expression = expression.replaceAll('÷', "/");

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch (e){
          'Error';
        }
      }else if(btnText == 'C') {
        equation = "0";
      }else{
        if (equation == "0"){
          equation = btnText;
        }
        equation = equation + btnText;
      }
    });
  }

  Widget calButtons(String btnText, Color textColor, double width, Color btnColor){
    return InkWell(
      onTap: (){
        buttonPressed(btnText);
      },
      child: Container(
        margin: EdgeInsets.all(1),
        alignment: Alignment.center,
        height: 80,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: btnColor,
        ),
        child: Text(btnText, style: TextStyle(color: textColor,fontWeight: FontWeight.bold,fontSize: 36),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.centerRight,
            color: Colors.black,
            height: 230,
            width: double.infinity,
            child:
                Text(equation, style: TextStyle(color: Colors.white, fontSize: 45)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButtons('CE', Colors.white, 100, Colors.white30),
              calButtons('C',  Colors.white, 100, Colors.white30),
              calButtons('⌫',  Colors.white, 100, Colors.white30),
              calButtons('÷',  Colors.white, 100, Colors.white30)
            ],
          ),
          SizedBox(height: 2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButtons('7', Colors.white, 100, Colors.white54),
              calButtons('8',  Colors.white, 100, Colors.white54),
              calButtons('9',  Colors.white, 100, Colors.white54),
              calButtons('x',  Colors.white, 100, Colors.white30)
            ],
          ),
          SizedBox(height: 2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButtons('4', Colors.white, 100, Colors.white54),
              calButtons('5',  Colors.white, 100, Colors.white54),
              calButtons('6',  Colors.white, 100, Colors.white54),
              calButtons('-',  Colors.white, 100, Colors.white30)
            ],
          ),
          SizedBox(height: 2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButtons('1', Colors.white, 100, Colors.white54),
              calButtons('2',  Colors.white, 100, Colors.white54),
              calButtons('3',  Colors.white, 100, Colors.white54),
              calButtons('+',  Colors.white, 100, Colors.white30)
            ],
          ),
          SizedBox(height: 2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButtons('±', Colors.white, 100, Colors.white54),
              calButtons('0',  Colors.white, 100, Colors.white54),
              calButtons('.',  Colors.white, 100, Colors.white54),
              calButtons('=',  Colors.white, 100, Colors.deepOrangeAccent)
            ],
          ),
        ],
      ),
    );
  }
}
