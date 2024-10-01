import 'package:atividade04/formularioPage.dart';
import 'package:atividade04/transacao.dart';
import 'package:flutter/material.dart';

class ListaTransacoesPage extends StatefulWidget {
  const ListaTransacoesPage({super.key});

  @override
  _ListaTransacoesPageState createState() => _ListaTransacoesPageState();
}

class _ListaTransacoesPageState extends State<ListaTransacoesPage> {
  List<Transacao> _transacoes = [];

  void _navegarParaFormulario({Transacao? transacao, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioPage(
          transacao: transacao,
        ),
      ),
    );

    if (result != null && result is Transacao) {
      setState(() {
        if (index != null) {
          _transacoes[index] = result;
        } else {
          _transacoes.add(result);
        }
      });
    }
  }

  void _removerTransacao(int index) {
    setState(() {
      _transacoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Transações'),
      ),
      body: _transacoes.isEmpty
          ? Center(child: Text('Nenhuma transação cadastrada'))
          : ListView.builder(
              itemCount: _transacoes.length,
              itemBuilder: (context, index) {
                final transacao = _transacoes[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      transacao.tipo == 'Depósito'
                          ? Icons.attach_money
                          : Icons.money_off,
                      color: transacao.tipo == 'Depósito'
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(
                        '${transacao.tipo} de R\$ ${transacao.valor.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _navegarParaFormulario(
                              transacao: transacao, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removerTransacao(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarParaFormulario(),
        child: Icon(Icons.add),
      ),
    );
  }
}
