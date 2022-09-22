import 'package:get_it/get_it.dart';
import 'package:weather_forecast/bloc/home/home_bloc.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
  }
}
