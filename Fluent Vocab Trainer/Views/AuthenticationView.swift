//
//  Login.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/6/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct AuthenticationView : View {
    
    @EnvironmentObject var session: SessionStore
    @State var signInSuccess = false
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        Group {
            if session.session != nil || signInSuccess {
                MenuView()
            }
            else {
                LoginView(signInSuccess: $signInSuccess)
            }
        }.onAppear(perform: getUser)
    }
}

//struct RegisterView: View {
//
//}

struct LoginView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var email = ""
    @State var password = ""
    @State var loading = false
    @State var error = false
    @Binding var signInSuccess: Bool
    private func signIn() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
                self.signInSuccess = false
            } else {
                self.email = ""
                self.password = ""
                self.signInSuccess = true
            }
        }
    }
    
    var body: some View {
        VStack {
            Group{
                Image(uiImage: UIImage(named: "Logo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(150)
                    .padding(.bottom, 75)
                TextField("Email", text: $email) {
                    UIApplication.shared.keyWindow?.endEditing(true)
                    }
                    .autocapitalization(.none)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                if (error) {
                    Text("Invalid Credentials")
                        .foregroundColor(Color.red)
                }
                VStack{
                    CustomButton(
                        label: "Login",
                        action: signIn,
                        loading: loading
                    )
                        .padding()
                }}
                
                .frame(width: 300, height: 60)
            //MARK: Implement forgot password
            //            NavigationLink(destination: SignUpView()) {
            //                Text("Sign up.").font(.footnote)
            //            }
            //            Text("Forgot Password").foregroundColor(Color.white)
            //                .underline()
            
        }
        .background(
            Image(uiImage: UIImage(named: "BgImage")!)
                .resizable()
                .frame(width: 450.0, height: 910.0)
                .aspectRatio(CGSize(width:50, height: 50), contentMode: .fit)
        )
    }
}

struct CustomButton : View {
    var label: String
    var action: () -> Void
    var loading: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
        }
        .padding()
        .frame(width: 250)
        .background(loading ? Color.purple.opacity(0.3) : Color.purple)
        .cornerRadius(5)
    }
}


#if DEBUG
struct AuthenticationView_Previews : PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(SessionStore())
    }
}
#endif
