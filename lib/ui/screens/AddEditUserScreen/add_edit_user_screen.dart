import 'package:flutter/material.dart';
import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/ui/widgets/custom_dropdown.dart';

import '../../../logic/services/validators.dart';
import '../../widgets/custom_textfield.dart';

class AddEditUserScreen extends StatefulWidget {
  AddEditUserScreen({Key? key, this.isEdit = false, this.userModal}) : super(key: key);

  bool isEdit;
  UserModal? userModal;
  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  Validators validators = Validators();

  String status = 'active';

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var designationController = TextEditingController();

  var mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      setValues();
    }
  }

  setValues() {
    if (widget.isEdit) {
      nameController.text = widget.userModal!.name;
      mobileController.text = widget.userModal!.mobile;
      // emailController.text=widget.userModal!.email;
      // designationController.text=widget.userModal!.designation;
      // status=widget.userModal!.isActive?'active':'inActive';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Update User' : 'Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFieldWidget(hint: 'Name', controller: nameController, onChanged: (value) {}, validator: validators.validateName),
                TextFieldWidget(hint: 'Email', controller: emailController, onChanged: (value) {}, validator: validators.validateEmail),
                TextFieldWidget(hint: 'Mobile', isNumber: true, controller: mobileController, onChanged: (value) {}, validator: validators.validateMobile),
                TextFieldWidget(controller: designationController, hint: 'Designation', onChanged: (value) {}, validator: validators.validateDesignation),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonWidget(
                    hint: 'Status',
                    selected: status,
                    onChange: (value) {
                      setState(() {
                        status = value!;
                      });
                    },
                    list: const ['active', 'inActive']),
                const SizedBox(
                  height: 8,
                ),
                // ElevatedButtonWidget(
                //     title: widget.isEdit ? 'Update' : 'Add',
                //     onPressed: () {
                //       if(_formKey.currentState!.validate()){
                //         if (widget.isEdit) {
                //           handleEditUser(context);
                //         } else {
                //           handleAddUser(context);
                //         }
                //       }
                //
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handleEditUser(BuildContext context) {
  //   var userModal = UserModal(
  //       id:widget.userModal!.id,
  //       name: nameController.text,
  //       mobile: designationController.text,
  //       cnic: emailController.text,
  //       // mobile: mobileController.text,
  //       // isActive: status == 'active',
  //       // isAdmin: false
  //   );
  //   print(status);
  //
  //   context.read<UserProvider>().updateUser(context, userModal);
  // }
  //
  //
  //
  // handleAddUser(BuildContext context) {
  //   var userModal = UserModal(
  //       userId: DateTime.now().toString(),
  //       name: nameController.text,
  //       designation: designationController.text,
  //       email: emailController.text,
  //       mobile: mobileController.text,
  //       isActive: status == 'active',
  //       isAdmin: false);
  //
  //   context.read<UserProvider>().addUser(context,userModal);
  // }
}
