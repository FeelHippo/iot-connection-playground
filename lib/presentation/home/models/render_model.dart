import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RenderModel extends Equatable {
  const RenderModel({required this.title, required this.widgets});

  final String title;
  final List<Widget> widgets;

  @override
  List<Object?> get props => <Object?>[title, widgets];
}
