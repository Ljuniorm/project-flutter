import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class FormTransfers extends StatelessWidget {
  final TextEditingController _controllerCampNumberAccount =
      TextEditingController();
  final TextEditingController _controllerCampValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferencia'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controllerCampNumberAccount,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: 'Numero da conta', hintText: '0000'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controllerCampValue,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: 'Valor',
                    hintText: '0.00',
                    icon: Icon(Icons.monetization_on)),
                keyboardType: TextInputType.number,
              ),
            ),
            RaisedButton(
              onPressed: () {
                debugPrint("clicou");
                final int numberAccount =
                    int.tryParse(_controllerCampNumberAccount.text);
                final double value = double.tryParse(_controllerCampValue.text);
                if (numberAccount != null && value != null) {
                  final TransferCreated = Transfer(value, numberAccount);
                  debugPrint('$TransferCreated');
                }
              },
              color: Colors.blue,
              child: Text('Confirmar'),
            )
          ],
        ));
  }
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormTransfers(),
      ),
    );
  }
}

class ListTransfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Column(children: <Widget>[
        ItemTransfers(Transfer(100, 1000)),
        ItemTransfers(Transfer(200, 1000)),
        ItemTransfers(Transfer(300, 1000))
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class ItemTransfers extends StatelessWidget {
  final Transfer _transfer;

  ItemTransfers(this._transfer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.numberAccount.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int numberAccount;

  Transfer(this.value, this.numberAccount);

  @override
  String toString() {
    return 'Transfer{value: $value, numberAccount: $numberAccount}';
  }
}
