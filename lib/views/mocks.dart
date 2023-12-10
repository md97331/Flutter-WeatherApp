import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Manual mock class for http.Client
class MockClient extends Mock implements http.Client {}