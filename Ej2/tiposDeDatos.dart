var dia = 'dijous';
String dia2 = 'dimarts';
int numero = 42;
bool laborable = true;

String cadena_numero = "1";
int numero_cadena = int.parse(cadena_numero);

const curs = 'Flutter';
int? variable1;
int variable2 = 2;

enum DiesSetmana { dilluns, dimarts, dimecres, dijous, divendres, dissabte, diumenge }
List<DiesSetmana> dies = DiesSetmana.values;

void main(List<String> args){
  int? variable1;
  print('• Operador d’asserció nul·la (null assertion operator) (!):') ;
  try{
    int variable2 = variable1!;
    print(variable2);
  }catch(e){
    print('Error: $e');
  }
  
  print('\n->Operador null ??') ;
  var nom;
  print(nom ?? 'Sense nom');

  print('\n->Assignació concient dels nulls:') ;
  int? variable11;
  print(variable11);
  variable11 ??= 10;
  print(variable11);
  variable11 ??= 15;
  print(variable11);

  DiesSetmana dia=DiesSetmana.dilluns;
  print('\n->Enum:') ;
  print(DiesSetmana.values);
  print(dia);
}