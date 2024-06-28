import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensiveApp());

class ExpensiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.purple,
          secondary: Colors.amber,
          tertiary: Colors.blue,
          brightness: Brightness.light,
          onPrimary: Colors.black,
          onSecondary: Colors.grey,
          error: Colors.red,
          onError: Colors.red,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontSize: 20,
          ),
        ),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 't0',
      title: 'Conta Velha',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't1',
      title: 'Tênis de corrida 1',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't0',
      title: 'Conta Velha',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't1',
      title: 'Tênis de corrida 1',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't0',
      title: 'Conta Velha',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't1',
      title: 'Tênis de corrida 1',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];
  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(
      () {
        _transaction.removeWhere((tr) => tr.id == id);
      },
    );
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(!_showChart ? Icons.bar_chart : Icons.list),
            color: Colors.white,
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
          color: Colors.white,
        ),
      ],
      title: Text(
        'Despesas pessoais',
        style:
            TextStyle(fontSize: 20.0 * MediaQuery.of(context).textScaleFactor),
      ),
    );
    final avaliabelHeigth = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir Gráfico'),
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              Container(
                height: avaliabelHeigth * (isLandscape ? 0.70 : 0.30),
                child: Chart(_recentTransaction),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: avaliabelHeigth * 0.70,
                child: TransactionList(_transaction, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
