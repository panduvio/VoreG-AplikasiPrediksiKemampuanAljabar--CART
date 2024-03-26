import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/usecases/data_cleaning_usecase.dart';
import 'package:skripsi/domain/usecases/get_all_data_usecase.dart';
import 'package:skripsi/dependency_injection.dart';
import 'package:skripsi/domain/usecases/post_data_usecase.dart';
import 'package:skripsi/domain/usecases/remove_this_data_usecase.dart';
import 'package:skripsi/domain/usecases/update_data_usecase.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> with ChangeNotifier {
  UserBloc() : super(TryToGetState()) {
    on<GetAllUser>(_getAllUser);
    on<PostUser>(_postUser);
    on<UpdateUser>(_updateUser);
    on<RemoveThisUser>(_removeThisUser);
    on<CleanData>(_cleanData);
  }

  void _getAllUser(GetAllUser event, Emitter<UserState> emit) async {
    emit(TryToGetState());
    try {
      final users = await sl<GetAllDataUsecase>().getAllData();
      emit(GetAllSuccessState(users));
    } catch (e) {
      throw Exception('Failed to get all data: $e');
    }
  }

  void _removeThisUser(RemoveThisUser event, Emitter<UserState> emit) async {
    emit(TryToRemoveState());
    try {
      await sl<RemoveThisDataUsecase>().removeData(event.id);
      add(GetAllUser());
    } catch (e) {
      throw Exception('Failed to remove this user: $e');
    }
  }

  void _postUser(PostUser event, Emitter<UserState> emit) async {
    emit(TryToPostState());
    try {
      await sl<PostDataUsecase>().postData(event.userData);
      add(GetAllUser());
    } catch (e) {
      throw Exception('Failed to post user: $e');
    }
  }

  void _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(TryToPostState());
    try {
      await sl<UpdateDataUsecase>().updateData(event.userData);
      add(GetAllUser());
    } catch (e) {
      throw Exception('Failed to post user: $e');
    }
  }

  void _cleanData(CleanData event, Emitter<UserState> emit) async {
    emit(TryToGetState());
    try {
      final userList =
          await sl<DataCleaningUsecase>().cleanData(event.userList);
      emit(CleanSuccessState(userList));
    } catch (e) {
      throw Exception('Failed to clean data: $e');
    }
  }
}
