<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _isLoading = false);
    // TODO: Navigate to Home
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEFF6FF), Color(0xFFFFFFFF), Color(0xFFF5F3FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2563EB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue shopping',
                  style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 32),

                // Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      const Text('Email Address',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF374151))),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'your@email.com',
                          prefixIcon: const Icon(Icons.mail_outline,
                              color: Color(0xFF9CA3AF)),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF2563EB), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password
                      const Text('Password',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF374151))),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFF9CA3AF)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF9CA3AF),
                            ),
                            onPressed: () =>
                                setState(() => _showPassword = !_showPassword),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF2563EB), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?',
                              style: TextStyle(
                                  color: Color(0xFF2563EB), fontSize: 13)),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2),
                                )
                              : const Text('Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      Row(children: [
                        const Expanded(
                            child: Divider(color: Color(0xFFE5E7EB))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Or continue with',
                              style: TextStyle(
                                  color: Color(0xFF9CA3AF), fontSize: 13)),
                        ),
                        const Expanded(
                            child: Divider(color: Color(0xFFE5E7EB))),
                      ]),
                      const SizedBox(height: 20),

                      // Social Buttons
                      Row(children: [
                        Expanded(
                          child: _SocialButton(
                            label: 'Google',
                            icon: _googleIcon(),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SocialButton(
                            label: 'Apple',
                            icon: const Icon(Icons.apple,
                                size: 20, color: Color(0xFF374151)),
                            onTap: () {},
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Link
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? ",
                      style:
                          TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon,
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color(0xFF4285F4);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.5, 0, size.width * 0.5, size.height * 0.5),
        paint);
    paint.color = const Color(0xFF34A853);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.5, size.height * 0.5, size.width * 0.5,
            size.height * 0.5),
        paint);
    paint.color = const Color(0xFFFBBC05);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.5, size.width * 0.5, size.height * 0.5),
        paint);
    paint.color = const Color(0xFFEA4335);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * 0.5, size.height * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
=======
import 'package:flutter/material.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() => _isLoading = false);
    // TODO: Navigate to Home
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEFF6FF), Color(0xFFFFFFFF), Color(0xFFF5F3FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2563EB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue shopping',
                  style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 32),

                // Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      const Text('Email Address',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF374151))),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'your@email.com',
                          prefixIcon: const Icon(Icons.mail_outline,
                              color: Color(0xFF9CA3AF)),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF2563EB), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password
                      const Text('Password',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF374151))),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFF9CA3AF)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF9CA3AF),
                            ),
                            onPressed: () =>
                                setState(() => _showPassword = !_showPassword),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF2563EB), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?',
                              style: TextStyle(
                                  color: Color(0xFF2563EB), fontSize: 13)),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2),
                                )
                              : const Text('Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      Row(children: [
                        const Expanded(
                            child: Divider(color: Color(0xFFE5E7EB))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Or continue with',
                              style: TextStyle(
                                  color: Color(0xFF9CA3AF), fontSize: 13)),
                        ),
                        const Expanded(
                            child: Divider(color: Color(0xFFE5E7EB))),
                      ]),
                      const SizedBox(height: 20),

                      // Social Buttons
                      Row(children: [
                        Expanded(
                          child: _SocialButton(
                            label: 'Google',
                            icon: _googleIcon(),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SocialButton(
                            label: 'Apple',
                            icon: const Icon(Icons.apple,
                                size: 20, color: Color(0xFF374151)),
                            onTap: () {},
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Link
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? ",
                      style:
                          TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon,
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color(0xFF4285F4);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.5, 0, size.width * 0.5, size.height * 0.5),
        paint);
    paint.color = const Color(0xFF34A853);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.5, size.height * 0.5, size.width * 0.5,
            size.height * 0.5),
        paint);
    paint.color = const Color(0xFFFBBC05);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.5, size.width * 0.5, size.height * 0.5),
        paint);
    paint.color = const Color(0xFFEA4335);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * 0.5, size.height * 0.5), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
>>>>>>> 48cd10b30859869fadb9dc3105e9b514bac01d7b
}