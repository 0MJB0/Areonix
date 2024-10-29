import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  final TextEditingController emailController = TextEditingController();
  final String selectedItem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo View'),
      ), // CommonAppbar yerine basit bir AppBar
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RoundTextFormField(
                  controller: emailController,
                  labelText: StringConstants.loginEmail,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ErrorConstants.loginMailError;
                    }
                    return null;
                  },
                ),
                DropdownDietician(
                  items: [],
                  selectedItem: selectedItem,
                  onChanged: (p0) {},
                  width: 20,
                  labelText: 'Mail',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
