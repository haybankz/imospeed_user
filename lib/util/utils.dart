class ImoUtil {

  static String parseError(Map<dynamic, dynamic> map){
    if(map == null) return 'Unable to complete your request';
    List<String> error = List();
    for (final name in map.keys) {
      dynamic value = map[name];
      for(final err in value) {
        error.add(err.toString() );
      }

    }

    return error.join(',');
  }
}