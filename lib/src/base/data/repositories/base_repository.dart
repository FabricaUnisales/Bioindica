import 'dart:io';

import 'package:bioindica/src/base/data/enums/module_type.dart';
import 'package:bioindica/src/core/errors/failures.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  final String _baseUrl = 'http:// api url aqui';
  final String _baseUrlLocation = 'https://geocode.maps.co';

  ///Método construtor da Classe
  BaseRepository();

  ///Método para configurar o Dio (client http)
  void configureDio(Dio dio, {int timeOutSeconds = 30}) {
    dio.options = BaseOptions(
      connectTimeout: Duration(seconds: timeOutSeconds),
      sendTimeout: Duration(seconds: timeOutSeconds),
      receiveTimeout: Duration(seconds: timeOutSeconds),
      headers: {'Content-Type': 'application/json'},
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) => _requestInterceptor(options, handler),
      onError: (DioException error, ErrorInterceptorHandler handler) => _errorInterceptor(dio, error, handler),
    ));
  }

  ///Método que configura o interceptor 'onRequest'.
  dynamic _requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('requiresToken')) {
      //Removendo o cabeçalho auxiliar
      options.headers.remove('requiresToken');

      //Se o token não está na memória, buscar novo token a partir do refresh token
      // if ( user token == null) {
      //   await ref.read(injectorContainer.authenticationProvider.notifier).getTokenWithRefreshToken();
      // }

      //Buscando token na memória
      // String token = // TODO - Buscar token na memória;
      // options.headers.addAll({'Authorization': 'Bearer $token'});
    }

    //Verificando se foi passado um tempo de timeout para reconfigurar o dio
    //(utilizado para enviar código de confirmação no e-mail)
    if (options.headers.containsKey('customTimeoutDutation')) {
      // configureDio(ref.read(injectorContainer.dioProvider), timeOutSeconds: options.headers['customTimeoutDutation']);
      options.headers.remove('customTimeoutDutation');
    }

    return handler.next(options);
  }

  ///Método que configura o interceptor 'onError'.
  dynamic _errorInterceptor(Dio dio, DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 403 || error.response?.statusCode == 401) {
      //Buscando novo token a a partir do refresh token
      // await ref.read(injectorContainer.authenticationProvider.notifier).getTokenWithRefreshToken();

      //Tentando novamente realizar o request que ocasionou o erro
      return dio.request(
        error.requestOptions.baseUrl + error.requestOptions.path,
        options: Options(headers: error.requestOptions.headers),
      );
    }

    return handler.next(error);
  }

  // ///Gera link do método
  String generateUrl({String method = '', ModuleType moduleType = ModuleType.authentication, bool locationRequest = false}) {
    if (locationRequest) return _baseUrlLocation + method;
    return _baseUrl + _getModule(moduleType) + method;
  }

  String _getModule(ModuleType type) {
    switch (type) {
      case ModuleType.authentication:
        return 'authentication/';
      case ModuleType.bio:
        return 'bio/';
    }
  }

  ///Método que checa os erros de conexão e os erros retornados pela API
  Failure checkError(error) {
    if (error is DioException && error.response != null && error.response!.data.isNotEmpty) {
      var errorData = ErrorData.fromJson(error.response!.data);
      return Failure(message: errorData.mensagemErro!.messages.join('\n'), code: error.response!.statusCode!);
    } else if (error.error is SocketException) {
      return Failure(erroConexaoRede: true, message: 'Não foi possível acessar o servidor. Por favor, verifique sua conexão de rede.');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Failure(message: 'Não foi possível acessar o servidor. Tempo Excedido.', code: 500);
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Failure(message: 'Não foi possível acessar o servidor. Tempo Excedido.', code: 500);
    } else if (error.type == DioExceptionType.sendTimeout) {
      return Failure(message: 'Não foi possível acessar o servidor. Tempo Excedido.', code: 500);
    } else if (error.type == DioExceptionType.badResponse) {
      return Failure(message: 'Esta funcionalidade não está disponível.', code: 404);
    } else if (error is Exception) {
      return Failure(message: error.toString());
    }

    return Failure(message: 'Não foi possível acessar o servidor.');
  }
}
