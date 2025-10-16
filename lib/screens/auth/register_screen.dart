
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:Carbon_Chillax/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                            'Create Account',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Start your green journey',
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  _buildTextField(controller: _emailController, label: 'Email', icon: Icons.email_outlined, validator: EmailValidator(errorText: 'enter a valid email address').call),
                  SizedBox(height: 20),
                  _buildTextField(controller: _passwordController, label: 'Password', icon: Icons.lock_outline, obscureText: true, validator: MinLengthValidator(6, errorText: 'password must be at least 6 digits long').call),
                  SizedBox(height: 20),
                  _buildTextField(controller: _confirmPasswordController, label: 'Confirm Password', icon: Icons.lock_outline, obscureText: true, validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val!, _passwordController.text)),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await context.read<ApiService>().register(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration successful! Please log in.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text('Sign Up', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: GoogleFonts.roboto(color: Colors.grey.shade600)),
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
      style: GoogleFonts.roboto(color: Colors.black87), // Set text color to black
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
        errorStyle: TextStyle(color: Colors.redAccent), // Optional: Custom error style
      ),
    );
  }
}
