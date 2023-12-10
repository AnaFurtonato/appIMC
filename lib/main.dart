import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,        
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

 class _MyHomePageState extends State<MyHomePage> {

  final _inputAltura = TextEditingController();
  final _inputPeso = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double _resultado = 0;
  String _label = '';
  Color _cor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cor,  
       
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,            
            children: <Widget> [ 
              Form(
                key: _formKey,
                child: Column(
                children: [
                  Text(
                  'I.M.C',
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                  ),
                  Text(
                    'Indice de massa corporal',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  TextFormField(    
                    controller: _inputAltura,                 
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    obscureText: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Altura',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty || double.parse(value) <= 0){
                          return 'Informe sua altura';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(   
                    controller: _inputPeso,                      
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    maxLength: 10,
                    obscureText: false,
                    decoration: const InputDecoration(
                      labelText: 'Peso',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty || double.parse(value) <= 0){
                          return 'Informe o seu peso';
                      }
                    },
                  ),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState?.validate() ?? false){
                        _resultado = double.parse(_inputPeso.text) / (double.parse(_inputAltura.text) * double.parse(_inputAltura.text));

                        if(_resultado < 18.5){
                          _label = "Magreza";
                          _cor = Colors.red;
                        } else if ( _resultado >= 18.5 && _resultado <= 24.9){
                          _label = "Normal";
                          _cor = Colors.green;
                        } else if ( _resultado > 25.0 && _resultado <= 29.9){
                          _label = "Sobrepeso";
                          _cor = const Color.fromARGB(255, 251, 255, 0);
                        } else if ( _resultado > 30.0 && _resultado <= 34.9){
                          _label = "Obrsidade grau I";
                          _cor = Colors.orange;
                        } else if ( _resultado > 35.0 && _resultado <= 39.9){
                          _label = "Obrsidade grau II";
                          _cor = const Color.fromARGB(255, 255, 102, 0);
                        } else {
                          _label = "Obrsidade grau III";
                          _cor = const Color.fromARGB(255, 255, 0, 0);
                        }

                        //_label = _resultado.toStringAsFixed(1);                       

                        setState(() {
                          
                        });
                    }
                  }, child: Text('Calcular', style: const TextStyle(color: Colors.black),),
                  ),          
                  GestureDetector(
                    onLongPress: (){
                      _cor = Colors.black;
                      _inputAltura.clear();
                      _inputPeso.clear();
                      _label = '';

                      setState(() {
                        
                      });
                    },
                    child: Text(
                      _label,
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              ))
            ],
          ),          
        ),
      ),
      
    );
  }
}
//double.parse(value) <= 0 = transforma o valor em numero e verifica se é menor que zero
//key: null = seria um id do formulario, para acionar ele 
//_formKey.currentState?.validate() ?? false = Se o status do formulario for valido, se tiver tudo escrito nos campos e não tiver faltando nada para dar as mensagens de validação
//_label = _resultado.toStringAsFixed(1); = coloca apenas um valor depois da virgula  
//Color _cor = Colors.black; = mudando acor de fundo de acordo com a cor que vai estar na variavel (Color é a "variavel" para declarar cor) 
//GestureDetector = adiciona um evento em algo que não tem evento 
//onLongPress: (){_cor = Colors.black; _inputAltura.clear(); _inputPeso.clear(); _label = ''; setState(() {});}, = 