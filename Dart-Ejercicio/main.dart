import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  if (args.length == 0 || args.length == 1) {
    print('Este programa necesita argumentos para funcionar');
    return;
  } else if (args.length >= 2) {
      if (args[0] == 'comarcas') {
        getComarcas(args[1]);
      } else if (args[0] == 'infoComarca'){
        if (args.length == 3){
          String comarca = args[1] + ' ' + args[2];
          getInfoComarca(comarca);
        }else if (args.length == 4){
          String comarca = args[1] + ' ' + args[2] + ' ' + args[3];
          getInfoComarca(comarca);
        }
      } else {
        print('El primer argumento debe ser "comarcas" o "infocomarca"');
        return;
      }
      return;
  }
}

void getInfoComarca(String comarca) async {
  comarca = comarca.replaceAll(' ', '%20');
  var url = Uri.parse('https://node-comarques-rest-server-production.up.railway.app/api/comarques/infocomarca/' + comarca);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> infoComarca;
    try {
      infoComarca = jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error al decodificar la respuesta: $e');
    }
    print('Comarca: ${infoComarca['comarca']}');
    print('Capital: ${infoComarca['capital']}');
    print('Población: ${infoComarca['poblacio']}');
    print('Imagen: ${infoComarca['img']}');
    print('Descripción: ${infoComarca['desc']}');
    print('Latitud: ${infoComarca['latitud']}');
    print('Longitud: ${infoComarca['longitud']}');
  } else {
    throw Exception('Error al obtener la información de la comarca, código de estado HTTP: ${response.statusCode}');
  }
}

void getComarcas(String provincia) async {
  var url = Uri.parse('https://node-comarques-rest-server-production.up.railway.app/api/comarques/' + provincia);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<String> comarcas;
    try {
      comarcas = List<String>.from(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Error al decodificar la respuesta: $e');
    }
    print(comarcas.join('\n'));
  } else {
    throw Exception('Error al obtener las comarcas, código de estado HTTP: ${response.statusCode}');
  }
}