import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';



class CommonTextFieldResult extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  List<TextInputFormatter>? inputFormatters = [];

  CommonTextFieldResult({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  State<CommonTextFieldResult> createState() => _CommonTextFieldResultState();
}

class _CommonTextFieldResultState extends State<CommonTextFieldResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.grey,
      ),
      autofocus: false,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      obscureText: widget.obSecure,
      minLines: widget.isMulti ? 4 : 1,
      maxLines: widget.isMulti ? null : 1,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        counterStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 25,
        ),
        errorMaxLines: 2,
        hintText: widget.hintText,
        errorText: widget.errorText,
        labelText: widget.labelText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffixIcon,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust the vertical padding here
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.validator,
    );

  }
}


class CommonTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  List<TextInputFormatter>? inputFormatters = [];

  CommonTextfield({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.grey,
      ),
      autofocus: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      obscureText: widget.obSecure,
      minLines: widget.isMulti ? 4 : 1,
      maxLines: widget.isMulti ? null : 1,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        counterStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 25,
        ),
        errorMaxLines: 2,
        hintText: widget.hintText,
        errorText: widget.errorText,
        labelText: widget.labelText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffixIcon,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust the vertical padding here
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      validator: widget.validator,
    );

  }
}

class CommonTextfieldReadOnly extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  List<TextInputFormatter>? inputFormatters = [];

  CommonTextfieldReadOnly({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obSecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  State<CommonTextfieldReadOnly> createState() => _CommonTextfieldReadOnlyState();
}

class _CommonTextfieldReadOnlyState extends State<CommonTextfieldReadOnly> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.grey,
      ),
      autofocus: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      obscureText: widget.obSecure,
      minLines: widget.isMulti ? 4 : 1,
      maxLines: widget.isMulti ? null : 1,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(

        counterStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 25,
        ),
        fillColor: AppThemes.disableColor,
        filled: true,
        errorMaxLines: 2,
        hintText: widget.hintText,
        errorText: widget.errorText,
        labelText: widget.labelText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffixIcon,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Adjust the vertical padding here
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      validator: widget.validator,
    );

  }
}



class CommonRow extends StatelessWidget {
  final String text1;
  final String text2;

  CommonRow({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // You can adjust the alignment as needed
          children: <Widget>[
            Text(text1,style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
                color: Colors.grey
            ),),
            Text(text2,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppThemes.black
            ),),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}