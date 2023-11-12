part of 'app_router_imports.dart';

pushNamed(BuildContext context, {required String route, Object? args}) =>
    Navigator.of(context).pushNamed(route, arguments: args);

pushReplacementNamed(BuildContext context, String route) =>
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);

navigateReplacement(BuildContext context, {required String route}) =>
    Navigator.of(context).pushReplacementNamed(route);

void pop(BuildContext context) => Navigator.pop(context);

