import 'package:flutter/material.dart';
import 'package:persistencia_de_dados_flutter/helpers/DbHelper.dart';


class MyHomePage extends StatelessWidget {

  //Referencia da classe single para gerenciar o banco de dados
  final dbHelper = DatabaseHelper.instance;

  //Layout da HomePage
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD com SQLite no Flutter'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Inserir Dados',style: TextStyle(fontSize: 20),),
              onPressed: (){_inserir();},
            ),
            RaisedButton(
              child: Text('Consultar Dados',style: TextStyle(fontSize: 20),),
              onPressed: (){_consultar();},
            ),
            RaisedButton(
              child: Text('Atualizar Dados',style: TextStyle(fontSize: 20),),
              onPressed: (){_atualizar();},
            ),
            RaisedButton(
              child: Text('Deletar Dados',style: TextStyle(fontSize: 20),),
              onPressed: (){_deletar();},
            ),
          ],
        ),
      ),
    );
  }

  //Métodos dos botões
  void _inserir() async{
    //Linha para inserir os dados
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome:'Iago',
      DatabaseHelper.columnIdade:27
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  //Método para a busca de todas os dados no banco
  void _consultar() async{
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta de todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }

  //Método para atualizar os dados no banco
  void _atualizar() async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnID: 1,
      DatabaseHelper.columnNome:'Maria',
      DatabaseHelper.columnIdade: 32
    };
    final linhasAtualizadas = await dbHelper.update(row);
    print('Atualizadas $linhasAtualizadas linhas(s)');
  }

  //Método para deletar os dados no banco
  void _deletar() async{
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id);
    print('Deletada $linhaDeletada linha: linha$id');
  }
}

