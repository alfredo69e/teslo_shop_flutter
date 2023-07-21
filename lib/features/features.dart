

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'dart:math' show pi;

import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/shared/infrastructure/infrastructure.dart';

part './auth/presentation/screens/login_screen.dart';
part './auth/presentation/screens/register_screen.dart';
part './auth/presentation/screens/check_auth_status.dart';

part './shared/widgets/custom_filled_button.dart';
part './shared/widgets/custom_text_form_field.dart';
part './shared/widgets/custom_product_field.dart';
part './shared/widgets/geometrical_background.dart';
part './shared/widgets/side_menu.dart';
part './shared/widgets/loading.dart';

part './shared/infrastructure/inputs/email.dart';
part './shared/infrastructure/inputs/password.dart';
part './shared/infrastructure/inputs/title.dart';
part './shared/infrastructure/inputs/price.dart';
part './shared/infrastructure/inputs/slug.dart';
part './shared/infrastructure/inputs/stock.dart';

part './auth/presentation/providers/login_form.provider.dart';
part './auth/presentation/providers/auth.provider.dart';

part './auth/domain/datasources/auth.datasource.dart';
part './auth/domain/entities/user.dart';
part './auth/domain/repositories/auth.repository.dart';

part './auth/infrastructure/datasources/auth.datasource.impl.dart';
part './auth/infrastructure/repositories/auth.repository.impl.dart';
part './auth/infrastructure/mappers/user.mapper.dart';
part './auth/infrastructure/errors/auth.error.dart';