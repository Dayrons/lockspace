import 'package:app/models/FtpClientModel.dart';
import 'package:bloc/bloc.dart';

part 'ftp_state.dart';

class FtpCubit extends Cubit<FtpClientModel?> {
  FtpCubit() : super(null);

  void upodateFtpCredentials(FtpClientModel ftpCredentials){
    emit(ftpCredentials);
  }
}
