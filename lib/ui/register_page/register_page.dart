import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wedding_app/data/user.dart';
import 'package:wedding_app/ui/home_page/widgets/title_widget.dart';
import 'package:intl/intl.dart';
import '../../blocs/auth/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final maskFormatter = MaskTextInputFormatter(mask: '+### (##) ###-##-##');
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<String> _cities = [
    'Toshkent',
    'Toshkent viloyati',
    'Andijon',
    'Buxoro',
    'Farg`ona',
    'Sirdaryo',
    'Jizzax',
    'Namangan',
    'Navoiy',
    'Qoraqalpog`iston Respublikasi',
    'Samarqand',
    'Surxondaryo',
    'Xorazm',
    'Qashqadaryo',
  ];

  String? _selectedCity;

  String? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    print(_phoneController.text);
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).textTheme.headline1?.copyWith(
          fontSize: 12.sp,
          color: const Color(0xFFABABAB),
        );
    return Scaffold(
      body: SafeArea(
        child: BlocListener(
          bloc: BlocProvider.of<AuthBloc>(context),
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(0xFF5785A9),
                    content: Text('Регистрация прошла успешно')));
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: IconButton(
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    const Spacer(),
                    const TitleWidget(title: 'Регистрация'),
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            TextFormField(
                              controller: _nameController,
                              validator: _validateName,
                              autofocus: true,
                              style: hintStyle,
                              decoration: InputDecoration(
                                  hintText: 'Имя Фамилия',
                                  hintStyle: hintStyle),
                            ),
                            SizedBox(height: 15.h),
                            GestureDetector(
                              onTap: () {
                                _getDateFromUser();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_selectedDate ?? 'ДАТА',
                                        style: hintStyle),
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: 'МЕСТО мероприятия',
                                hintStyle: hintStyle,
                              ),
                              style: hintStyle,
                              items: _cities.map((city) {
                                return DropdownMenuItem(
                                  child: Text(city),
                                  value: city,
                                );
                              }).toList(),
                              onChanged: (String? city) {
                                setState(() {
                                  _selectedCity = city;
                                });
                              },
                              value: _selectedCity,
                            ),
                            SizedBox(height: 5.h),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                maskFormatter,
                              ],
                              style: hintStyle,
                              decoration: InputDecoration(
                                hintText: '+998 __ ___ __ __',
                                hintStyle: hintStyle,
                              ),
                            ),
                            SizedBox(height: 65.h),
                            ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 15.h)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF5785A9),
                                ),
                              ),
                              child: const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 4.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              }
              if (state is AuthError) {
                return const Center(child: Text("ERORR"));
              }
              if (state is AuthSuccess) {
                return const Center(child: Text('Success'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: IconButton(
                      iconSize: 30,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  const Spacer(),
                  const TitleWidget(title: 'Регистрация'),
                  SizedBox(height: 30.h),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        children: [
                          TextFormField(
                            controller: _nameController,
                            validator: _validateName,
                            autofocus: true,
                            style: hintStyle,
                            decoration: InputDecoration(
                                hintText: 'Имя Фамилия', hintStyle: hintStyle),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () {
                              _getDateFromUser();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_selectedDate ?? 'ДАТА',
                                      style: hintStyle),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'МЕСТО мероприятия',
                              hintStyle: hintStyle,
                            ),
                            style: hintStyle,
                            items: _cities.map((city) {
                              return DropdownMenuItem(
                                child: Text(city),
                                value: city,
                              );
                            }).toList(),
                            onChanged: (String? city) {
                              setState(() {
                                _selectedCity = city;
                              });
                            },
                            value: _selectedCity,
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              maskFormatter,
                            ],
                            style: hintStyle,
                            decoration: InputDecoration(
                              hintText: '+998 __ ___ __ __',
                              hintStyle: hintStyle,
                            ),
                          ),
                          SizedBox(height: 65.h),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 15.h)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF5785A9),
                              ),
                            ),
                            child: const Text('Зарегистрироваться'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String phone = _phoneController.text.substring(6);
      var formattedPhone = '';
      for (var i = 0; i < phone.length; i++) {
        try {
          formattedPhone += int.parse(phone[i]).toString();
        } catch (_) {}
      }
      final User user = User(
        username: _nameController.text,
        phone: formattedPhone,
        cite: _selectedCity ?? '',
        weddingDate: _selectedDate!,
      );
      print("${user.phone} ${user.username}");

      context.read<AuthBloc>().add(
          AuthLogin(user.username, user.phone, user.cite, user.weddingDate));
      _formKey.currentState?.save();

      _nameController.text = '';
      phone = '';
      _selectedCity = null;
      _selectedDate = null;
    }
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      // locale: const Locale("ru", "RU"),
      cancelText: 'Отменить',
      confirmText: 'Готово',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2121),
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickerDate);
      });
    } else {
      print('Something went wrong');
    }
  }
}

String? _validateName(String? value) {
  final nameExp = RegExp(r'^[A-Z a-z]+$');

  if (value!.isEmpty) {
    return 'Введите ваше имя';
  } else if (!nameExp.hasMatch(value)) {
    return 'Пожалуйста, введите буквы алфавита';
  } else {
    return null;
  }
}
