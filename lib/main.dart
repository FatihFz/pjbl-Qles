import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'register_screen.dart';
import 'student_dashboard_screen.dart'; // Ganti 'student_dashboard_screen.dart' menjadi 'student_dashboard.dart'
import 'settings_screen.dart';   // Import settings
import 'edit_profile_screen.dart'; // Import edit profile
import 'profile_model.dart'; // Import model

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileModel(), // Inisialisasi model di sini
      child: MaterialApp(
        title: 'Classroom App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.grey[50],
          fontFamily: 'Inter',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        initialRoute: '/', // Default route
        routes: {
          '/': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(), // Untuk logout
        },
        // home: const LoginScreen(), // <-- Baris ini dihapus untuk menghindari konflik
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedRole = 'Student';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.book_outlined,
                  size: 60,
                  color: Colors.deepPurple.shade400,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Classroom',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Learn and teach together',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),
                _buildLoginForm(),
                const SizedBox(height: 30),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildRegisterLink(),
                const SizedBox(height: 40),
                _buildDemoAccountsInfo(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Role',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildRoleButton('Student')),
            const SizedBox(width: 16),
            Expanded(child: _buildRoleButton('Teacher')),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleButton(String role) {
    final bool isSelected = _selectedRole == role;
    return isSelected
        ? ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedRole = role;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(role, style: const TextStyle(fontSize: 16)),
          )
        : OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedRole = role;
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey[700],
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(role, style: const TextStyle(fontSize: 16)),
          );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print('Email: ${_emailController.text}');
          print('Password: ${_passwordController.text}');
          print('Role: $_selectedRole');

          if (_emailController.text == 'student@demo.com' &&
              _passwordController.text == 'student123' &&
              _selectedRole == 'Student') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StudentDashboardScreen()),
            );
          } else if (_emailController.text == 'teacher@demo.com' &&
              _passwordController.text == 'teacher123' &&
              _selectedRole == 'Teacher') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Teacher login successful!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid credentials or role')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade400,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey[600]),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Register',
            style: TextStyle(
              color: Colors.deepPurple.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoAccountsInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo Accounts:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Teacher: teacher@demo.com / teacher123',
            style: TextStyle(color: Colors.deepPurple[800]),
          ),
          const SizedBox(height: 4),
          Text(
            'Student: student@demo.com / student123',
            style: TextStyle(color: Colors.deepPurple[800]),
          ),
        ],
      ),
    );
  }
}