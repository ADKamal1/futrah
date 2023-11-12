import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/components.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/integration/bluetooth/print_page.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/view/screens/add_category/cubit/category_cubit.dart';
import 'package:futrah/view/screens/add_category/cubit/category_state.dart';
import 'package:futrah/view/screens/add_category/view/widgets/add_category_filed.dart';
import 'package:futrah/view/screens/add_category/view/widgets/category_list.dart';
import 'package:futrah/view/screens/auth/view/widgets/login_btn.dart';
import 'package:futrah/view/screens/home/view/screen/home_imports.dart';
import 'package:futrah/view/widgets/cancel_button.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/custom_condition.dart';
import 'package:futrah/view/widgets/custom_loading.dart';
import 'package:futrah/view/widgets/my_text.dart';

part 'add_category_view.dart';