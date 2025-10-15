import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Carbon_Chillax/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset('assets/images/carbon_chillex_logo.png', height: 80),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Reset your password',
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  _buildTextField(controller: _emailController, label: 'Email', icon: Icons.email_outlined, validator: EmailValidator(errorText: 'enter a valid email address')),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthService>().sendPasswordResetEmail(
                              email: _emailController.text.trim(),
                            );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset email sent.')),
                        );
                      }
                    },
                    child: Text('Send Reset Email', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Remembered your password?', style: GoogleFonts.roboto(color: Colors.grey.shade600)),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Login', style: GoogleFonts.roboto(color: Colors.green.shade700, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, bool obscureText = false, required String? Function(String?) validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.green.shade700),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
