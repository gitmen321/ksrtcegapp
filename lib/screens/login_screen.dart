import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksrtcegapp/screens/dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var pwd_visibility = true;
  var userController = TextEditingController();
  var pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150,),
              Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color:  Color.fromARGB(255, 5, 95, 151),),),
              const SizedBox(height: 45,),
              // Text("Username"),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  border: OutlineInputBorder(),
                  labelText: "UserName",
                  hintText: 'Enter your Username here',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Text("Password"),
              TextField(
                controller: pwdController ,
                obscureText:pwd_visibility ,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      if(pwd_visibility==true){
                        pwd_visibility=false;
                      }else{
                        pwd_visibility=true;
                      }
                    });
                  }, icon: Icon(
                      pwd_visibility==true? Icons.visibility_off : Icons.visibility
                  )),
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  hintText: 'Enter your Password here',
                ),
              ),
              const SizedBox(height: 45,),
              MaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                },
                color:  Color.fromARGB(255, 5, 95, 151),
                minWidth: 300,
                shape: const StadiumBorder(),
                child: Text("Log in", style: GoogleFonts.sahitya(
                    fontSize: 20,
                    fontWeight:FontWeight.bold,
                    color: Colors.white),),),
              const SizedBox(height: 25,),
               const Image(image:  AssetImage("assets/images/ksrtcblue.png"),
               ),

            ],
          ),
        ),
     ),
);
}
}
