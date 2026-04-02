import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _acceptTerms = false;
  bool _isLoading = false;

  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms and conditions')),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Google Sign-In failed')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark || 
                (themeProvider.themeMode == ThemeMode.system && 
                 MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark 
                  ? [const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF0F172A)]
                  : [const Color(0xFFF5F3FF), const Color(0xFFFFFFFF), const Color(0xFFEFF6FF)],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        color: isDark ? Colors.amber : Colors.grey,
                        size: 20,
                      ),
                      Switch(
                        value: isDark,
                        activeColor: const Color(0xFF3B82F6),
                        onChanged: (value) => themeProvider.toggleTheme(value),
                      ),
                    ],
                  ),
                ),

                    const SizedBox(height: 16),
                    Text('Create Account',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF111827))),
                    const SizedBox(height: 8),
                    Text('Sign up to start shopping',
                        style: TextStyle(fontSize: 15, color: isDark ? Colors.white70 : const Color(0xFF6B7280))),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Full Name', isDark),
                          _buildTextField(controller: _nameController, hint: 'John Doe', icon: Icons.person_outline, isDark: isDark),
                          const SizedBox(height: 16),
                          _buildLabel('Email Address', isDark),
                          _buildTextField(controller: _emailController, hint: 'your@email.com', icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress, isDark: isDark),
                          const SizedBox(height: 16),
                          _buildLabel('Password', isDark),
                          _buildTextField(
                            isDark: isDark,
                            controller: _passwordController,
                            hint: 'Create a password',
                            icon: Icons.lock_outline,
                            obscure: !_showPassword,
                            suffixIcon: IconButton(
                              icon: Icon(_showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF9CA3AF)),
                              onPressed: () => setState(() => _showPassword = !_showPassword),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Confirm Password', isDark),
                          _buildTextField(
                            isDark: isDark,
                            controller: _confirmPasswordController,
                            hint: 'Confirm your password',
                            icon: Icons.lock_outline,
                            obscure: !_showConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(_showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF9CA3AF)),
                              onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _acceptTerms,
                                onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                                activeColor: const Color(0xFF2563EB),
                                side: BorderSide(color: isDark ? Colors.white38 : Colors.grey),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF6B7280), fontSize: 13),
                                      children: const [
                                        TextSpan(text: 'I agree to the '),
                                        TextSpan(text: 'Terms and Conditions', style: TextStyle(color: Color(0xFF2563EB))),
                                        TextSpan(text: ' and '),
                                        TextSpan(text: 'Privacy Policy', style: TextStyle(color: Color(0xFF2563EB))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: _isLoading
                                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(children: [
                            Expanded(child: Divider(color: isDark ? Colors.white12 : const Color(0xFFE5E7EB))),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Or sign up with', style: TextStyle(color: isDark ? Colors.white38 : const Color(0xFF9CA3AF), fontSize: 13)),
                            ),
                            Expanded(child: Divider(color: isDark ? Colors.white12 : const Color(0xFFE5E7EB))),
                          ]),
                          const SizedBox(height: 20),
                          Row(children: [
                            Expanded(child: _SocialButton(label: 'Google', icon: const Icon(Icons.g_mobiledata, size: 24, color: Color(0xFF4285F4)), onTap: _handleGoogleSignIn,)),
                            const SizedBox(width: 12),
                            Expanded(child: _SocialButton(label: 'Apple', icon: Icon(Icons.apple, size: 20, color: isDark ? Colors.white : const Color(0xFF374151)), onTap: () {})),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have an account? ', style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF6B7280), fontSize: 14)),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                        child: const Text('Sign In', style: TextStyle(color: Color(0xFF2563EB), fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : const Color(0xFF374151))),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isDark,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white38 : const Color(0xFF9CA3AF)),
        prefixIcon: Icon(icon, color: const Color(0xFF2563EB)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF9FAFB),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white10 : const Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white10 : const Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2)),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(12),
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF374151),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}