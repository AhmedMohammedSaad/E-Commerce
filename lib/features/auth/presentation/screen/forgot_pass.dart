// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController controller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        if (state is ResetPasswordFailure) {
          Future.microtask(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          });
        } else if (state is ResetPasswordSuccess) {
          Future.microtask(() {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Check your email'),
              ),
            );
          });
        }
        return state is ResetPasswordLoading
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  size: 80,
                  color: ColorManager.green,
                ),
              )
            : Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _key,
                      child: Column(
                        spacing: 100,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Forgot",
                            style: StyleTextApp
                                .font24ColorblacColorFontWeightBolde,
                          ),
                          TextFiealdApp(
                            controller: controller,
                            hintText: "Gmail",
                          ),
                          BottonAPP(
                            onTap: () {
                              cubit.resetPassword(controller.text);
                              // Navigator.pushNamed(context, '/newPass');
                            },
                            nameBotton: 'Send Gmail',
                            colorBotton: ColorManager.green,
                            colorText: ColorManager.white,
                            width: double.infinity,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
