import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:flutter/material.dart';

class CommentBoxWidget extends StatelessWidget {
  final CombinedModel cModel;
  const CommentBoxWidget({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    String _text = '';
    _text = cModel.comment;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.sticky_note_2_outlined,
            size: 35,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              initialValue: _text,
              cursorColor: Colors.green,
              keyboardType: TextInputType.text,
              maxLength: 10,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Agregar comentario (Opcional)',
                labelText: 'Agregar comentario (Opcional)',
                floatingLabelStyle: TextStyle(color: Colors.green),
                hintStyle: const TextStyle(
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              onChanged: (txt) => cModel.comment = txt,
            ),
          ),
        ],
      ),
    );
  }
}
