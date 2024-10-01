import 'package:atividade04/transacao.dart';
import 'package:flutter/material.dart';

class FormularioPage extends StatefulWidget {
  final Transacao? transacao;

  FormularioPage({this.transacao});

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valorController = TextEditingController();
  String _tipoTransacao = 'Depósito';

  @override
  void initState() {
    super.initState();
    if (widget.transacao != null) {
      _tipoTransacao = widget.transacao!.tipo;
      _valorController.text = widget.transacao!.valor.toString();
    }
  }

  void _salvarTransacao() {
    if (_formKey.currentState!.validate()) {
      final novaTransacao = Transacao(
        _tipoTransacao,
        double.parse(_valorController.text),
      );
      Navigator.pop(context, novaTransacao);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.transacao == null ? 'Nova Transação' : 'Editar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _tipoTransacao,
                onChanged: (String? novoValor) {
                  setState(() {
                    _tipoTransacao = novoValor!;
                  });
                },
                items: ['Depósito', 'Saque']
                    .map<DropdownMenuItem<String>>((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Tipo de Transação'),
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor da Transação'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTransacao,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
