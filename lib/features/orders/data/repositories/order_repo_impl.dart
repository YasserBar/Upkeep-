import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repo.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order.dart';

typedef GetOrdersModel = Future<List<MyOrderModel>> Function();

class OrderRepoImpl extends OrderRepo {
  final OrderRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OrderRepoImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> acceptOrder(int orderId) async {
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
      return remoteDataSource.acceptOrder(orderId, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> blockUserFoundation(
      int userId, int foundationId) async {
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
      return remoteDataSource.blockUserFoundation(
          userId, foundationId, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> blockUserService(
      int userId, int foundationServiceId) async {
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
      return remoteDataSource.blockUserService(
          userId, foundationServiceId, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> cancelOrder(int orderId) async {
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
      return remoteDataSource.cancelOrder(orderId, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, List<MyOrder>>> getAllOrderForAllService(
      int page, int foundationId) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getOrders(() {
      return remoteDataSource.getAllOrderForAllService(
          page, foundationId, token!);
    });
  }

  @override
  Future<Either<Failure, List<MyOrder>>> getAllOrderForService(
      int page, int id) async {
   final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getOrders(() {
      return remoteDataSource.getAllOrderForService(
          page, id, token!);
    });
  }

  @override
  Future<Either<Failure, Unit>> rejectedOrder(int orderId) async {
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
      return remoteDataSource.rejectedOrder(orderId, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> setAssessment(
      int orderId, int assessment) async {
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
      return remoteDataSource.setAssessment(
          orderId, assessment, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, List<MyOrder>>> getAllOrder(int page) async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await _getOrders(() {
      return remoteDataSource.getAllOrder(page, token!);
    });
  }

  Future<Either<Failure, List<MyOrderModel>>> _getOrders(
      GetOrdersModel func) async {
    return performRequest<List<MyOrderModel>>(func, networkInfo);
  }
}
