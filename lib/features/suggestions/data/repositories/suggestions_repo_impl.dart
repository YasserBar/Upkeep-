import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/my_suggestions.dart';
import '../../domain/entities/propose.dart';
import '../../domain/repositories/suggestions_repo.dart';
import '../datasources/suggestion_remote_data_source.dart';
import '../models/my_suggestions.dart';
import '../models/propose.dart';

typedef GetListSuggestions = Future<List<MySuggestionModel>> Function();
typedef PostPropose = Future<Unit> Function();

class SuggestionsRepoImpl extends SuggestionsRepo {
  final SuggestionsRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SuggestionsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MySuggestion>>> getAllMyPropose(
      int foundationId, int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getResponse(() {
      return remoteDataSource.getAllMyPropose(foundationId, page, token!);
    });
  }

  @override
  Future<Either<Failure, Unit>> proposeNewService(Propose propose) async {
    final ProposeModel proposeModel = ProposeModel(
        foundationId: propose.foundationId,
        description: propose.description,
        classService: propose.classService,
        nameService: propose.nameService);
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.proposeNewService(proposeModel, token!);
    }, networkInfo);
  }

  Future<Either<Failure, List<MySuggestion>>> _getResponse(
      GetListSuggestions func) async {
    return performRequest<List<MySuggestion>>(func, networkInfo);
  }
}
