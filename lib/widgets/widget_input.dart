import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';

class WidgetInput extends StatefulWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hint, errorText, labelText, initialValue;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final double? height;
  final bool? obscureText;
  final TextInputType? inputType;
  final Widget? leadIcon;
  final Widget? endIcon;
  final bool? enabled, isBorder;
  final FocusNode? focusNode;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextInputAction? textInputAction;
  const WidgetInput(
      {Key? key,
      this.focusNode,
      this.inputController,
      this.onChanged,
      this.validator,
      this.hint,
      this.errorText,
      this.labelText,
      this.initialValue,
      this.maxLine = 1,
      this.minLine = 1,
      this.maxLength,
      this.height = 80,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textInputAction = TextInputAction.go,
      this.leadIcon,
      this.endIcon,
      this.enabled = true,
      this.isBorder = true,
      })
      : super(key: key);

  @override
  _WidgetInputState createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: widget.isBorder! ? Border.all(width: 0.5, color: COLORS.BLACK) : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment!,
        children: [
          widget.leadIcon != null ? Padding(
            padding: EdgeInsets.only(left: 5),
            child: Center(child: Container(height: 25, width: 25, child: widget.leadIcon)),
          ) : Container(),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                key: widget.key,
                controller: widget.inputController,
                onChanged: (change) => widget.onChanged!(change),
                enabled: widget.enabled,
                validator: widget.validator,
                style: AppStyle.DEFAULT_SMALLs,
                maxLines: widget.maxLine,
                minLines: widget.minLine,
                keyboardType: widget.inputType,
                textAlign: TextAlign.left,
                obscureText: widget.obscureText!,
                initialValue: widget.initialValue,
                focusNode: widget.focusNode,
                textAlignVertical: TextAlignVertical.top,
                textInputAction: widget.textInputAction,
                maxLength: widget.maxLength,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  labelStyle: AppStyle.DEFAULT_SMALLs.copyWith(color: COLORS.PRIMARY_COLOR),
                  hintText: widget.hint,
                  errorText: widget.errorText,
                  errorStyle: AppStyle.DEFAULT_SMALL.copyWith(color: COLORS.RED),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          widget.endIcon != null ? Padding(
            padding: EdgeInsets.only(right: 5),
            child: Center(child: Container(height: 25, width: 25, child: widget.endIcon)),
          ) : Container()
        ],
      ),
    );
  }
}

