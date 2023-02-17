import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_boutton.dart';

import '../../constants/sizes.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => BirthdayScreenState();
}

class BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController BirthdayController = TextEditingController();

  String Birthday = "";

  @override
  void initState() {
    super.initState();
    BirthdayController.addListener(() {
      setState(() {
        Birthday = BirthdayController.text;
      });
    });
  }

  @override
  void dispose() {
    BirthdayController.dispose();
    super.dispose();
  }

  void onNextTap() {
    //따로 onNextTap 안에 context를 보내지 않아도 된다.
    //StatefulWidget안에 State안에 있다면 어디서든 context를 사용할수 있기 때문이다.
    if (_birthday.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: BirthdayController,
              decoration: InputDecoration(
                hintText: "BirthDay",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: onNextTap,
              child: FormButton(
                disabled: Birthday.isEmpty,
              ),
            )
          ],
        ),
      ),
    );
  }
}
