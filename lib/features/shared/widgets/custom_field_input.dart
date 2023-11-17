import 'package:flutter/material.dart';

class CustomFieldInput extends StatelessWidget {
  final FormFieldValidator<String>? validator; // Cambiado el tipo de dato
  final Widget? sufix;
  final TextEditingController textController;
  final String label;
  final Widget? icon;
  final bool? obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const CustomFieldInput({
    Key? key, // Cambiado de super.key a Key? key
    required this.label,
    this.icon,
    this.sufix,
    this.onChanged,
    this.obscureText,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.validator, // Añadido el campo validator al constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            validator: validator, // Usar la función validator proporcionada
            controller: textController,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              prefixIcon: icon,
              suffixIcon: sufix,
              label: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
