import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Import the reusable widgets this screen needs
import 'widgets/custom_app_bar.dart';
import 'widgets/footer.dart';

// The file now starts directly with the main widget for this screen.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    // This Scaffold is the root of your registration page.
    return Scaffold(
      // Use the reusable AppBar, giving it a specific title for this page.
      appBar: const CustomAppBar(
        
      ),
      // The body contains the content unique to this page.
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FormSection(), // This is where you will build your form.
          ),
          // Use the reusable Footer at the bottom.
          if (kIsWeb) const FooterSection(),
        ],
      ),
    );
  }
}

/// A widget that contains the actual registration form fields.
class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    // TODO: Build your actual registration form here with TextFormField, etc.
    // For now, it's a placeholder.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      // Set a minimum height to ensure it fills some space, especially on desktop.
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200, // Screen height minus AppBar and Footer
      ),
      child: const Center(
        child: Text(
          'Registration form fields will go here.',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}