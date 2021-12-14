// ignore_for_file: unnecessary_new
import 'package:projet2/db/DataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet2/Model/Article.dart';
import 'package:projet2/src/myapp.dart';
import 'package:sqflite/sqlite_api.dart';

class ajoutt extends StatelessWidget {
  const ajoutt({Key? key}) : super(key: key);
  static const String _title = 'Ajout Produit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: SingleChildScrollView(
        child: const Ajout(),
      ),
    );
  }
}

class Ajout extends StatefulWidget {
  const Ajout({Key? key}) : super(key: key);

  @override
  State<Ajout> createState() => _MyStatefulWidgetState();
}

enum Rad { Option1, Option2 }

class _MyStatefulWidgetState extends State<Ajout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Article art = new Article(0, "", 0.0);
  bool option1 = false;
  bool option2 = false;
  Rad? _character = Rad.Option1;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widgetCodeProduit(),
          widgetLibelleProduit(),
          widgetQuantiteProduit(),
          widgetCaseAcocherOption1(),
          widgetCaseAcocherOption2(),
          widgetRadio(),
          ShowSnackbar(),
          ShowAlert(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      DataBaseHelper db = new DataBaseHelper();
                      db.add(art);
                      print(db.getArticles());
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Reset'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget widgetCodeProduit() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Code",
        hintText: 'Enter la Code du Produit',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter number';
        } else if (int.parse(value) <= 100 || int.parse(value) >= 1000) {
          return 'Please enter a number between 100 and 1000 !';
        }
        return null;
      },
      onSaved: (String? value) {
        art.code = int.parse(value!);
      },
    );
  }

  Widget widgetLibelleProduit() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Libellé",
        hintText: 'Entrer la libellé',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (value.length > 15) {
          return 'Your text is too long !';
        }
        return null;
      },
      onSaved: (String? value) {
        art.lib = value!;
      },
    );
  }

  Widget widgetQuantiteProduit() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Quantity",
        hintText: 'Enter la Quantité du Produit',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          AlertDialogue();
        }
        return null;
      },
      onSaved: (String? value) {
        art.qte = double.parse(value!);
      },
    );
  }

  Widget widgetCaseAcocherOption1() {
    return FormField(builder: (State) {
      return Column(
        children: [
          CheckboxListTile(
              title: Text("Option 1"),
              subtitle: Text("cette option permet de xxx"),
              value: option1,
              onChanged: (bool? value) {
                setState(() {
                  option1 = value!;
                });
              }),
          Text(
            State.errorText ?? '',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          )
        ],
      );
    });
  }

  Widget widgetCaseAcocherOption2() {
    return FormField(
      builder: (State) {
        return Column(
          children: [
            CheckboxListTile(
                title: Text("Option 2"),
                subtitle: Text("cette option permet de xxx"),
                value: option2,
                onChanged: (bool? value) {
                  setState(() {
                    option2 = value!;
                  });
                }),
            Text(
              State.errorText ?? '',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        );
      },
      validator: (value) {
        if (option1 == false && option2 == false) {
          return "You have to choose an option !";
        }
        return null;
      },
    );
  }

  Widget widgetRadio() {
    return Column(
      children: <Widget>[
        RadioListTile(
          title: const Text('Option 1'),
          value: Rad.Option1,
          groupValue: _character,
          onChanged: (Rad? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile(
          title: const Text('Option 2'),
          value: Rad.Option2,
          groupValue: _character,
          onChanged: (Rad? value) {
            setState(() {
              _character = value;
            });
          },
        ),
      ],
    );
  }

  Widget Snackbar() {
    return SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.red[400],
    );
  }

  Widget snackbar() {
    return SnackBar(
      content: const Text('look at this snackbar !'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
  }

  Widget ShowSnackbar() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('look at this snackbar !'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget AlertDialogue() {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget ShowAlert() {
    return Center(
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Text('Show Dialog'),
      ),
    );
  }
}
