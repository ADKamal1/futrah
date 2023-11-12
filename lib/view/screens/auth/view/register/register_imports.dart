import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/components.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/auth/cubit/login_cubit.dart';
import 'package:futrah/view/screens/auth/cubit/login_state.dart';
import 'package:futrah/view/screens/auth/view/widgets/auth_logo.dart';
import 'package:futrah/view/screens/auth/view/widgets/login_btn.dart';
import 'package:futrah/view/screens/auth/view/widgets/login_filed.dart';
import 'package:futrah/view/widgets/change_lang_btn.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/custom_condition.dart';

import '../../../../../controller/resources/theme/colors_manager.dart';
import '../../cubit/login_cubit.dart';
import '../../cubit/login_state.dart';
import '../widgets/login_filed.dart';

part 'register_screen.dart';
