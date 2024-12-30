import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailFormScreen extends StatefulWidget {
  @override
  _EmailFormScreenState createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final Email email = Email(
        body: _descriptionController.text,
        subject: _titleController.text,
        recipients: ['Jadoonkhan4455@gmail.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email Sent Successfully')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _currentLanguage = 'en';
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language_code') ?? 'en';

  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.ecogreen,
          title: Text(
            languageProvider.translate('Send Email'),
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _titleController,
                labelText: 'Title',
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendEmail,
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
