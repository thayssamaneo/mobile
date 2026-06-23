import 'package:flutter/material.dart';
import '../controllers/financeiro_controller.dart';
import '../models/categoria_model.dart';
import '../models/transacao_model.dart';

class CategoriaDetalhesScreen extends StatefulWidget {
  final Categoria categoria;
  const CategoriaDetalhesScreen({super.key, required this.categoria});

  @override
  State<CategoriaDetalhesScreen> createState() => _CategoriaDetalhesScreenState();
}

class _CategoriaDetalhesScreenState extends State<CategoriaDetalhesScreen> {
  final FinanceiroController _controller = FinanceiroController();
  late Future<List<Transacao>> _futureTransacoes;
  late Future<Map<String, double>> _futureResumo;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    setState(() {
      _futureTransacoes = _controller.listarTransacoesPorCategoria(widget.categoria.id!);
      _futureResumo = _controller.obterResumoCategoria(widget.categoria.id!);
    });
  }

  void _abrirModalNovaTransacao() {
    final formKey = GlobalKey<FormState>();
    final valorController = TextEditingController();
    final descController = TextEditingController();
    String tipoTransacao = 'despesa';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20, left: 16, right: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Nova Transação", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: descController,
                      decoration: const InputDecoration(labelText: "Descrição"),
                      validator: (v) => v!.isEmpty ? "Campo obrigatório" : null,
                    ),
                    TextFormField(
                      controller: valorController,
                      decoration: const InputDecoration(labelText: "Valor (R\$)"),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) {
                        if (v!.isEmpty) return "Campo obrigatório";
                        if (double.tryParse(v) == null) return "Número inválido";
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: tipoTransacao,
                      items: const [
                        DropdownMenuItem(value: 'despesa', child: Text("Despesa")),
                        DropdownMenuItem(value: 'receita', child: Text("Receita")),
                      ],
                      onChanged: (v) => setModalState(() => tipoTransacao = v!),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF415A77)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final t = Transacao(
                            categoriaId: widget.categoria.id!,
                            descricao: descController.text,
                            valor: double.parse(valorController.text),
                            data: DateTime.now().toString().split(' ')[0],
                            tipo: tipoTransacao,
                          );
                          await _controller.inserirTransacao(t);
                          Navigator.pop(context);
                          _carregarDados();
                        }
                      },
                      child: const Text("Adicionar", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria.nome, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF415A77),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Painel de Resumos e Totais
          FutureBuilder<Map<String, double>>(
            future: _futureResumo,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              final dados = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFF4F6F8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResumoItem("Receitas", dados['receitas']!, Colors.green),
                    _buildResumoItem("Despesas", dados['despesas']!, Colors.red),
                    _buildResumoItem("Balanço", dados['balanco']!, dados['balanco']! >= 0 ? Colors.blue : Colors.orange),
                  ],
                ),
              );
            },
          ),
          // Lista de Transações da Categoria
          Expanded(
            child: FutureBuilder<List<Transacao>>(
              future: _futureTransacoes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhuma transação nesta categoria."));
                }
                final transacoes = snapshot.data!;
                return ListView.builder(
                  itemCount: transacoes.length,
                  itemBuilder: (context, index) {
                    final t = transacoes[index];
                    final isDespesa = t.tipo == 'despesa';
                    return ListTile(
                      leading: Icon(
                        isDespesa ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isDespesa ? Colors.red : Colors.green,
                      ),
                      title: Text(t.descricao),
                      subtitle: Text(t.data),
                      trailing: Text(
                        "${isDespesa ? '-' : '+'} R\$ ${t.valor.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDespesa ? Colors.red : Colors.green,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF415A77),
        onPressed: _abrirModalNovaTransacao,
        child: const Icon(Icons.add_card, color: Colors.white),
      ),
    );
  }

  Widget _buildResumoItem(String label, double valor, Color cor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text("R\$ ${valor.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cor)),
      ],
    );
  }
}