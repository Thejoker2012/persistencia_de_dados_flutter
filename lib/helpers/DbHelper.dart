import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  //Nome do banco de dados
  static final _DATABASENAME = "ExemploDB.db";
  static final _DATABASEVERSION = 1;

  //Criando tabela
  static final table = 'contato';
  static final columnID = '_Id';
  static final columnNome = 'nome';
  static final columnIdade = 'idade';

  //Torna esta classe um singleton
  DatabaseHelper._privateConstrutor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstrutor();

  //Tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;

    //Instancia o Database quando for iniciado a primeira vez
    _database = await _initDatabase();
    return _database;
  }

  //Abre o banco de dados e cria se não existir
  _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _DATABASENAME);
    return await openDatabase(path,
                              version: _DATABASEVERSION,
                              onCreate: _onCreate);
  }

  //Código SQL para a criação do banco de dados e tabelas
  Future _onCreate(Database db, int version) async{
    await db.execute('''
          CREATE TABLE $table (
            $columnID INTEGER PRIMARY KEY,
            $columnNome TEXT NOT NULL,
            $columnIdade INTEGER NOT NULL
          )
          ''');
  }

  //Método helper
  //Insere uma linha no banco de dados onde cada chave no Map
  //é o nome de coluna e o valor é o valor da coluna
  //O valor de retorno é o id da linha inserida
  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(table,row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    return await db.update(table, row, where: '$columnID = ?', whereArgs: [id]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnID = ?', whereArgs: [id]);
  }









}