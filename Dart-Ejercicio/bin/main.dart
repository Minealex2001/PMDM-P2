// Importamos las bibliotecas necesarias
import 'dart:convert';
import 'package:http/http.dart' as http;

// Definimos la función principal
void main(List<String> args) {

  // Definimos la función principal
  if (args.length == 0 || args.length == 1) {

    // Si el primer argumento es 'comarcas', llamamos a la función getComarcas
    print('Este programa necesita argumentos para funcionar');
    return;
  } else if (args.length >= 2) {

    // Si el primer argumento es 'comarcas', llamamos a la función getComarcas
      if (args[0] == 'comarcas') {
        getComarcas(args[1]);

        // Si el primer argumento es 'infoComarca', llamamos a la función getInfoComarca
      } else if (args[0] == 'infoComarca'){

        //Comprobamos si el nombre de la comarca tiene más de una palabra
        if (args.length == 3){

          //Si tiene más de una palabra, las juntamos en una sola
          String comarca = args[1] + ' ' + args[2];
          getInfoComarca(comarca);
        }else if (args.length == 4){
          String comarca = args[1] + ' ' + args[2] + ' ' + args[3];
          getInfoComarca(comarca);

          //Si solo tiene una palabra, llamamos a la función getInfoComarca
        }else
          getInfoComarca(args[1]);
      } else {

        // Si el primer argumento no es 'comarcas' o 'infoComarca', mostramos un mensaje de error
        print('El primer argumento debe ser "comarcas" o "infocomarca"');
        return;
      }
      return;
  }
}

// Definimos la función getInfoComarca
void getInfoComarca(String comarca) async {

  // Comprobamos si el nombre tiene espacios y los modificamos para que la URL sea válida
  comarca = comarca.replaceAll(' ', '%20');

  // Realizamos la petición HTTP
  var url = Uri.parse('https://node-comarques-rest-server-production.up.railway.app/api/comarques/infocomarca/' + comarca);

  // Comprobamos si la petición ha sido correcta
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> infoComarca;
    try {
      infoComarca = jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error al decodificar la respuesta: $e');
    }

    Comarca comarca = Comarca(
      nombre: infoComarca['comarca'],
      capital: infoComarca['capital'],
      poblacion: infoComarca['poblacio'],
      imagen: infoComarca['img'],
      descripcion: infoComarca['desc'],
      latitud: infoComarca['latitud'],
      longitud: infoComarca['longitud'],
    );

    print(comarca);
  } else {
    throw Exception('Error al obtener la información de la comarca, código de estado HTTP: ${response.statusCode}');
  }
}

// Definimos la función getComarcas
void getComarcas(String provincia) async {

  // Comprobamos si el nombre tiene espacios y los modificamos para que la URL sea válida
  var url = Uri.parse('https://node-comarques-rest-server-production.up.railway.app/api/comarques/' + provincia);

  // Realizamos la petición HTTP
  var response = await http.get(url);

  // Comprobamos si la petición ha sido correcta
  if (response.statusCode == 200) {

    List<String> comarcas;

    try {

      // Decodificamos la respuesta
      comarcas = List<String>.from(jsonDecode(response.body));
    } catch (e) {

      // Si no se ha podido decodificar la respuesta, mostramos un mensaje de error
      throw Exception('Error al decodificar la respuesta: $e');
    }

    // Mostramos las comarcas
    print(comarcas.join('\n'));
  } else {

    // Si la petición no ha sido correcta, mostramos un mensaje de error
    throw Exception('Error al obtener las comarcas, código de estado HTTP: ${response.statusCode}');
  }
}

class Comarca {
  String nombre;
  String capital;
  String poblacion;
  String imagen;
  String descripcion;
  double latitud;
  double longitud;

  Comarca({
    required this.nombre,
    required this.capital,
    required this.poblacion,
    required this.imagen,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
  });

  @override
  String toString() {
    return 'Comarca: $nombre\n'
        'Capital: $capital\n'
        'Población: $poblacion\n'
        'Imagen: $imagen\n'
        'Descripción: $descripcion\n'
        'Latitud: $latitud\n'
        'Longitud: $longitud\n';
  }
}