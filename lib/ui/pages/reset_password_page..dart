class ResetPasswordPage extends StatefulWidget {
  final ResetPasswordData resetPasswordData;
  ResetPasswordPage(this.resetPasswordData);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.resetPasswordData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: Colors.grey)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultmargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text("Creat New\n Account",
                              style: blackTextFont.copyWith(fontSize: 20)),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: 90,
                      height: 104,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        (widget.resetPasswordData.profileImage ==
                                                null)
                                            ? AssetImage("assets/user_pic.png")
                                            : FileImage(widget
                                                .resetPasswordData.profileImage),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (widget.resetPasswordData.profileImage ==
                                    null) {
                                  widget.resetPasswordData.profileImage =
                                      await getImage();
                                } else {
                                  widget.resetPasswordData.profileImage = null;
                                }

                                setState(() {});
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage((widget
                                                    .resetPasswordData
                                                    .profileImage ==
                                                null)
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_del_photo.png"))),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(height: 36),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "email",
                      hintText: "email",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    controller: retypePasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Konfirmasi Password",
                      hintText: "Konfirmasi Password",
                    ),
                  ),
                  SizedBox(height: 30),
                  FloatingActionButton(
                    child: Icon(
                      Icons.arrow_forward,
                    ),
                    backgroundColor: mainColor,
                    elevation: 0,
                    onPressed: () {
                      if (!(emailController.text.trim() != "" &&
                          passwordController.text.trim() != "" &&
                          retypePasswordController.text.trim() != "")) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Please fill all the field",
                        )..show(context);
                      } else if (passwordController.text !=
                          retypePasswordController.text) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Mismatch password and confirmed password",
                        )..show(context);
                      } else if (passwordController.text.length < 6) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Password's length min 6 characters",
                        )..show(context);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Wrong format email address",
                        )..show(context);
                      } else {
                        widget.resetPasswordData.email = emailController.text;
                        widget.resetPasswordData.password =
                            passwordController.text;

                        context.bloc<PageBloc>().add(
                            GoToAccountConfirmationPage(
                                widget.resetPasswordData));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
