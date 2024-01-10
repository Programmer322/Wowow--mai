import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/pages/home/user/logic.dart';

import '../../../../../components/widgets/app_tool_bar.dart';
import '../../../../../components/widgets/password_text_field.dart';
import '../../../../../config/app_strings.dart';
import '../../../../../config/app_toast.dart';
import '../../../../../request/app_request.dart';
import '../../../../../styles/app_colors.dart';
import 'logic.dart';

class EditPasswordPage extends StatefulWidget {
  EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final userLogic = Get.find<UserLogic>();

  final logic = Get.put(EditPasswordLogic());
  bool _isLengthRight = false;
  bool _isRepeatRight = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.editPassword),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AppPasswordTextField(
              maxLength: 18,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9a-zA-Z!@#%^&*()\$,.?":{}|<>]'))
              ],
              labelText: '请输入密码',
              hint: AppStrings.password,
              onChanged: (value) {
                if (value.length > 5 && value.length <= 18) {
                  setState(() {
                    _isLengthRight = true;
                  });
                } else {
                  setState(() {
                    _isLengthRight = false;
                  });
                }
                logic.password = value;
                if (logic.password == logic.repeatPassword &&
                    logic.password != '') {
                  setState(() {
                    _isRepeatRight = true;
                  });
                } else {
                  setState(() {
                    _isRepeatRight = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            AppPasswordTextField(
              maxLength: 18,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9a-zA-Z!@#%^&*()\$,.?":{}|<>]'))
              ],
              labelText: '请再次输入密码',
              hint: AppStrings.password,
              onChanged: (value) {
                logic.repeatPassword = value;
                if (logic.password == logic.repeatPassword &&
                    logic.repeatPassword != '') {
                  setState(() {
                    _isRepeatRight = true;
                  });
                } else {
                  setState(() {
                    _isRepeatRight = false;
                  });
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 0.8,
                      child: Radio(
                        value: _isLengthRight,
                        groupValue: true,
                        onChanged: (value) {},
                        activeColor: Colors.green[200],
                      )),
                  const Text(
                    '请输入6至18位密码',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.font2,
                      fontSize: 12,

                      fontWeight: FontWeight.w400,
                      height: 1.83,
                      letterSpacing: -0.43,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 0.8,
                      child: Radio(
                        value: _isRepeatRight,
                        groupValue: true,
                        onChanged: (value) {},
                        activeColor: Colors.green[200],
                      )),
                  const Text(
                    '两次输入密码相同',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.font2,
                      fontSize: 12,

                      fontWeight: FontWeight.w400,
                      height: 1.83,
                      letterSpacing: -0.43,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackElevated,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_isRepeatRight && _isLengthRight) {
                      logic.onConfirm();
                    } else {
                      appShowToast('请确保输入密码符合条件');
                    }
                  }, //
                  child: const Text(
                    AppStrings.confirm,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,

                      fontWeight: FontWeight.w400,
                      height: 1.38,
                      letterSpacing: -0.43,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
