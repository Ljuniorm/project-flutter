import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListTransfers(),
      ),
    );
  }
}

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
            Edit(
                controller: _controllerCampNumberAccount,
                label: "Numero da conta",
                hint: "0000"),
            Edit(
                controller: _controllerCampValue,
                label: "Valor",
                hint: "0.00",
                icon: Icons.monetization_on),
            RaisedButton(
              onPressed: () => _createTransfer(context),
              color: Colors.blue,
              child: Text('Confirmar'),
            )
          ],
        ));
  }

  void _createTransfer(BuildContext context) {
    final int numberAccount = int.tryParse(_controllerCampNumberAccount.text);
    final double value = double.tryParse(_controllerCampValue.text);
    if (numberAccount != null && value != null) {
      final transferCreated = Transfer(value, numberAccount);
      debugPrint("$transferCreated");
      Navigator.pop(context, transferCreated);
    }
  }
}

class Edit extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  Edit({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            icon: icon != null ? Icon(icon) : null),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListTransfers extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return ListTransferState();
  }
}

class ListTransferState extends State<ListTransfers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return ItemTransfers(transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormTransfers();
          }));
          future.then((transferReceived) {
            debugPrint("chegou no then do future");
            debugPrint("$transferReceived");
            widget._transfers.add(transferReceived);
          });
        },
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
