import 'package:mobile/imports.dart';

class MyInput extends StatefulWidget {
  final Function onChanged;
  final String hintText;
  final IconData icon;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validation;

  const MyInput(
      {required this.onChanged,
      required this.hintText,
      required this.icon,
      required this.keyboardType,
      required this.labelText,
      required this.validation,
      super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyInputState();
  }
}

class _MyInputState extends State<MyInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          validator: widget.validation,
          onChanged: (value) {
            widget.onChanged(value);
          },
          obscureText: widget.keyboardType == TextInputType.visiblePassword
              ? _obscureText
              : false,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.red),
            ),
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(widget.icon, color: Colors.white),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 40, minHeight: 40),
            hintText: widget.hintText,
            // errorText: errorText,
            suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(
                        color: Colors.white,
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
