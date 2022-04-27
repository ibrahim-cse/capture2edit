import 'package:capture2edit/model/user_model.dart';
import 'package:capture2edit/services/api_service_impl.dart';

class ApiService {
  final ApiServiceImpl _service = ApiServiceImpl();

  Future<bool> doSigning(UserModel data) => _service.doSigning(data);
}
