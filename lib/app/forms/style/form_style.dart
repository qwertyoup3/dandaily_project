import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FormStyle extends NyFormStyle {
  /// TextField styles
  @override
  FormStyleTextField textField(BuildContext context, Field field) {
    return {
      'minimal': (NyTextField textField) => textField.copyWith(
              decorator: DecoratorTextField(
            decoration: (dynamic data, InputDecoration inputDecoration) =>
                inputDecoration.copyWith(
              filled: true,
              fillColor: Colors.grey.shade100,
              isDense: true,
              hintText: field.name,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.transparent)),
              contentPadding: const EdgeInsetsDirectional.symmetric(
                  vertical: 13, horizontal: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            successDecoration:
                (dynamic data, InputDecoration inputDecoration) =>
                    inputDecoration.copyWith(
              prefixIcon: const Icon(Icons.person),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.green, width: 2)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
            errorDecoration: (dynamic data, InputDecoration inputDecoration) =>
                inputDecoration.copyWith(
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                    border: InputBorder.none),
          )),
      'default': (NyTextField textField) => textField.copyWith(
              decorator: DecoratorTextField(
            decoration: (dynamic data, InputDecoration inputDecoration) =>
                inputDecoration.copyWith(
              filled: true,
              fillColor: Colors.grey.shade100,
              isDense: true,
              hintText: field.name,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.transparent)),
              contentPadding: const EdgeInsetsDirectional.symmetric(
                  vertical: 13, horizontal: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            successDecoration:
                (dynamic data, InputDecoration inputDecoration) =>
                    inputDecoration.copyWith(
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.green, width: 2)),
            ),
            errorDecoration: (dynamic data, InputDecoration inputDecoration) =>
                inputDecoration.copyWith(
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.orange, width: 2),
              ),
              errorStyle: const TextStyle(color: Colors.red),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.orange, width: 2),
              ),
            ),
          )),
    };
  }

  /// Checkbox styles
  // @override
  // FormStyleCheckbox checkbox(BuildContext context, Field field) {
  //   return {
  //     'default': () => FormCast.checkbox(
  //
  //     ),
  //   };
  // }
}
