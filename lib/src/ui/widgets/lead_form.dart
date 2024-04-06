import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_cars/src/bloc/car_bloc.dart';
import 'package:teste_cars/src/bloc/car_event.dart';
import 'package:teste_cars/src/bloc/car_state.dart';
import 'package:teste_cars/src/constants/colors.dart';
import 'package:teste_cars/src/ui/widgets/buttons/custom_button.dart';
import 'package:teste_cars/src/ui/widgets/inputs/custom_input.dart';

class LeadForm extends StatefulWidget {
  final int carId;

  const LeadForm({super.key, required this.carId});

  @override
  State<LeadForm> createState() => _LeadFormState();
}

class _LeadFormState extends State<LeadForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarBloc, CarState>(
      listener: (context, state) {
        if (state is LeadSubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Interesse registrado com sucesso!',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (state is LeadSubmissionFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is LeadSubmissionInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildForm(context);
        }
      },
    );
  }

  void _submitLead() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<CarBloc>(context).add(SubmitLead(
        name: _name,
        email: _email,
        phone: _phone,
        carId: widget.carId,
      ));
    }
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              labelText: 'Nome',
              onSaved: (value) => _name = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Por favor, insira seu nome' : null,
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomTextFormField(
              labelText: 'Email',
              onSaved: (value) => _email = value!,
              validator: validateEmail,
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomTextFormField(
              labelText: 'Telefone',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              onSaved: (value) => _phone = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Por favor, insira seu telefone' : null,
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomButton(
              onTap: _submitLead,
              text: 'ENVIAR',
              colorButton: CustomColors.terciaryColor,
            ),
          ],
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);

    if (value == null || value.isEmpty) {
      return 'O campo de email não pode ser vazio.';
    } else if (!regex.hasMatch(value)) {
      return 'Insira um email válido.';
    } else {
      return null;
    }
  }
}
