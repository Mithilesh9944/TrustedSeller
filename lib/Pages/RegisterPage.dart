import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Security/SecurityDetails.dart';
import 'package:flutter_project/Util/UtilPages.dart';
import 'package:flutter_project/Security/SecurityPasswordField.dart';
import 'package:flutter_project/Services/api_service.dart';
import 'package:flutter_project/Util/UtilWidgets.dart';

class MyRegister extends StatefulWidget {
  MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UtilWidgets.buildBackgroundContainer(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 109, 190, 231),
          title: Text('Trustify'),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.help_outline_rounded)),
            TextButton(onPressed: (){}, child: Text('Help  ',style: TextStyle(fontSize: 20),))
          ],
        ),

        backgroundColor: Colors.transparent,
        body: Padding(
          padding:UtilitiesPages.buildPadding(context),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                _buildUserIcon(),
                _buildFormContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // User icon positioned at the top
  Widget _buildUserIcon() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.35,
      child: Image.asset(
        'assets/userIcon.png',
        height: 70,
        width: 70,
      ),
    );
  }

  // Main form container
  Widget _buildFormContainer() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        // left: UtilitiesPages.LEFT,
        // right: UtilitiesPages.RIGHT,
      ),
      child: Column(
        children: [
          _buildTextField(_userNameController, 'Enter your Name'),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
          _buildMobileNumberField(),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
          const PassphrasePasswordField(),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
          _buildTextField(_confirmPasswordController, 'Confirm Password'),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
          _buildTextField(_emailController, 'Enter Your Email'),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
          _buildRegisterButton(),
          SizedBox(height: UtilitiesPages.SIZE_BOX_HEIGHT),
        ],
      ),
    );
  }

  // Mobile number field with specific input formatting
  Widget _buildMobileNumberField() {
    return _buildTextField(
      _mobileNumberController,
      'Enter your Mobile Number',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }

  // Generic text field builder
  Widget _buildTextField(
      TextEditingController controller,
      String hintText, {
        TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: '    $hintText',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: UtilitiesPages.BOX_VERTICAL_SIZE,
          horizontal: UtilitiesPages.BOX_HORIZONTAL_SIZE,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UtilitiesPages.BOX_BORDER_RADIUS),
        ),
      ),
    );
  }

  // Register button with styling
  Widget _buildRegisterButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - (2 * UtilitiesPages.LEFT),
      child: ElevatedButton(
        onPressed: _submitRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 109, 174, 231),
          padding: EdgeInsets.symmetric(vertical: UtilitiesPages.BOX_VERTICAL_SIZE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UtilitiesPages.BOX_BORDER_RADIUS),
          ),
        ),
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: UtilitiesPages.OPTION_FONT_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Handle registration submission with validation
  void _submitRegister() {
    _setDetails();

    if (_validateInputs()) {
      _registerUser();
      _logUserDetails();
    }
  }

  // Set user details from text controllers
  void _setDetails() {
    Details.userName = _userNameController.text;
    Details.mobile = _mobileNumberController.text;
    Details.password = PassphrasePasswordField.passwordController.text;
    Details.confirmPassword = _confirmPasswordController.text;
    Details.email = _emailController.text;
  }

  // Input validation logic
  bool _validateInputs() {
    if (_isAnyFieldEmpty()) {
      _showSnackBar("All fields are required.");
      return false;
    } else if (Details.mobile?.length != 10) {
      _showSnackBar("Please enter a valid 10-digit mobile number.");
      return false;
    } else if (!_isValidEmail(Details.email)) {
      _showSnackBar("Please enter a valid Gmail or NIT KKR email.");
      return false;
    } else if (Details.password != Details.confirmPassword) {
      _showSnackBar("Passwords do not match.");
      return false;
    }
    return true;
  }

  // Check if any field is empty
  bool _isAnyFieldEmpty() {
    return [
      Details.userName,
      Details.mobile,
      Details.email,
      Details.password,
      Details.confirmPassword
    ].any((field) => field == null || field!.isEmpty);
  }

  // Validate email domain
  bool _isValidEmail(String? email) {
    return email != null && (email.endsWith("@gmail.com") || email.endsWith("@nitkkr.ac.in"));
  }

  // Show error message in snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Register user by calling the API
  void _registerUser() {
    var userData = {
      "userName": Details.userName,
      "mobileNo": Details.mobile,
      "password": Details.password,
      "email": Details.email,
    };
    ApiService.RegisterUser(userData);
  }

  // Log user details for debugging
  void _logUserDetails() {
    print('Username: ${Details.userName}');
    print('Mobile: ${Details.mobile}');
    print('Email: ${Details.email}');
    print('Password: ${Details.password}');
  }
}