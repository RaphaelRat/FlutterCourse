import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/pages.dart';

import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                child: SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Aguarde...', textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              );
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1('login'),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                                //Aqui fiz uma semântica diferente
                                errorText: snapshot.data == '' ? null : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                                  //Aqui fiz uma semântica diferente
                                  errorText: snapshot.data == '' ? null : snapshot.data,
                                ),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: presenter.isFormValidStream,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true ? presenter.auth : null,
                                child: Text('Entrar'.toUpperCase()),
                              );
                            }),
                        FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                          label: Text('Criar Conta'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
