
import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/presenter/components/disable_text_field_widget.dart';
import 'package:busca_cep_clean/app/presenter/search_cep_store.dart';
import 'package:busca_cep_clean/app/presenter/states/search_cep_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SearchCepPage extends StatefulWidget {
  const SearchCepPage({Key? key}) : super(key: key);

  @override
  State<SearchCepPage> createState() => _SearchCepPageState();
}

class _SearchCepPageState extends State<SearchCepPage> {

  final SearchCepStore store = Modular.get<SearchCepStore>();

  var maskFormatter = MaskTextInputFormatter(mask: '##.###-###', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Busca CEP",
            style: TextStyle(
              fontWeight: FontWeight.w700
            )
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Observer(
            builder: (context) {
              return Container(
                constraints: BoxConstraints(
                  minHeight: store.state is SuccessState
                    ? 0
                    : MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: TextField(
                        onChanged: store.setSearchCep,
                        inputFormatters: [maskFormatter],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.pin_drop_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2
                            )
                          ),
                          labelText: "Digite o CEP",
                          hintText: "Ex: 01034-030",
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (_) {
                        var state = store.state;
                  
                        if(state is ErrorState) {
                          return _buildError(state.error);
                        }
                  
                        if(state is StartState) {
                          return _buildStart();
                        } else if(state is LoadingState) {
                          FocusScope.of(context).unfocus();
                          return _buildLoading();
                        } else if(state is SuccessState) {
                          return _buildSuccess(state.cep);
                        } else {
                          return Container();
                        }
                      }
                    ),
                    const SizedBox()
                  ],
                ),
              );
            }
          ),
        )
      ),
    );
  }

  Widget _buildError(FailureSearch error) {
    if(error is InvalidCepTextError) {
      return Column(
        children: [
          _textScreen("CEP digitado inválido"),
          const SizedBox(height: 15),
          Image.asset(
            "assets/images/invalid.png",
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ]
      );
    } else if(error is DatasourceError) {
      return Column(
        children: [
          _textScreen("Erro na conexão com o servidor"),
          const SizedBox(height: 15),
          Image.asset(
            "assets/images/error.png",
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      );
    } 
    return Column(
      children: [
        _textScreen("Erro interno"),
        const SizedBox(height: 15),
        Image.asset(
          "assets/images/error.png",
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ],
    );
  }

  Widget _buildStart() {
    return Column(
      children: [
        _textScreen("Digite acima o CEP que deseja procurar"),
        const SizedBox(height: 15),
        Image.asset(
          "assets/images/location.png",
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 5,
        ),
      )
    );
  }

  Widget _buildSuccess(CepEntity cep) {
    return Column(
      children: [
        Icon(
          Icons.keyboard_double_arrow_down_rounded,
          color: Theme.of(context).primaryColor,
          size: 60,
        ),
        const SizedBox(height: 15),
        DisableTextFieldWidget(label: "Rua", text: cep.rua),
        DisableTextFieldWidget(label: "Bairro", text: cep.bairro),
        DisableTextFieldWidget(label: "Cidade", text: cep.cidade),
        DisableTextFieldWidget(label: "UF", text: cep.uf)
      ],
    );
  }

  Widget _textScreen(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 22,
        fontWeight: FontWeight.w700
      ),
    );
  }
}