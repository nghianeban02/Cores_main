import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cores_bloc_state.dart';

class CoresBlocCubit extends Cubit<CoresBlocState> {
  CoresBlocCubit() : super(CoresBlocInitial());

  bool checkList = true;
  onChangeList(bool typeList) {
    checkList = typeList;
    emit(CoresOnchangeList(typeList: checkList));
  }

  onChangeTabRegister(int index) {
    print(index);
    emit(CoresOnchangeTabRegister(index: index));
  }
}
