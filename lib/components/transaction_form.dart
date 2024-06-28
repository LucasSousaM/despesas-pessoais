import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _tittleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _SubmitForm() {
    final title = (_tittleController.text);
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + (MediaQuery.of(context).viewInsets.bottom),
          ),
          child: Column(
            children: [
              TextField(
                controller: _tittleController,
                onSubmitted: (_) => _SubmitForm(),
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: 'Título',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary))),
              ),
              TextField(
                controller: _valueController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: 'Valor (R\$)',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary))),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _SubmitForm(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: _SubmitForm,
                    child: Text('Nova transação'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
