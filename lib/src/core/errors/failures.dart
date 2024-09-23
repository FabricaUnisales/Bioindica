///Objeto que guarda os dados das mensagens de falhas
class Failure {
  final bool erroConexaoRede;
  final int? code;
  final String message;

  Failure({
    this.erroConexaoRede = false,
    required this.message,
    this.code,
  });
}

class ServerFailure {
  final String title;
  final int status;
  final ServerFailureMessageResponse? mensagemErro;

  ServerFailure({required this.title, required this.status, required this.mensagemErro});

  ServerFailure.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        status = json['status'],
        mensagemErro = json['errors'] != null ? ServerFailureMessageResponse.fromJson(json['errors']) : null;
}

class ServerFailureMessageResponse {
  final List<String> messages;

  ServerFailureMessageResponse({required this.messages});

  factory ServerFailureMessageResponse.fromJson(Map<String, dynamic> json) {
    List<String> messages = List.empty();

    json.forEach((key, value) {
      messages = List<String>.from(value);
    });

    return ServerFailureMessageResponse(messages: messages);
  }
}

///Objeto usado para mapear os erros retornados do servidor
class ErrorData {
  final String title;
  final int status;
  final ErrorMessage? mensagemErro;

  ErrorData({required this.title, required this.status, required this.mensagemErro});

  ErrorData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        status = json['status'],
        mensagemErro = json['errors'] != null ? ErrorMessage.fromJson(json['errors']) : null;
}

///Objeto usado para mapear as mensagens de erro retornadas do servidor
class ErrorMessage {
  final List<String> messages;

  ErrorMessage({required this.messages});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    List<String> messages = [];

    json.forEach((key, value) {
      messages = List<String>.from(value);
    });

    return ErrorMessage(messages: messages);
  }
}