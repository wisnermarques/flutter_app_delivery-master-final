import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/app.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) => runApp(const App()));
}
