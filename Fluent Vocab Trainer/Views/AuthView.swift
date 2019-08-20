//
//  Login.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/6/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView : View {
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                Text("Hello user!")
            } else {
                LoginView()
            }
        }.onAppear(perform: getUser)
    }
    
}

struct LoginView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var email = ""
    @State var password = ""
    @State var loading = false
    @State var error = false
    
    func signIn() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Group{
                TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                if (error) {
                    Text("Invalid Credentials")
                }
                Button(action: signIn) {
                    LoginButton()
                }}
                .frame(width: 350, height: 60)
            Text("Forgot Password").foregroundColor(Color.white)
            .underline()
            
        }
        .background(
            Image(uiImage: UIImage(named: "BgImage")!)
                .resizable()
                .frame(width: 450.0, height: 910.0)
                .aspectRatio(CGSize(width:50, height: 50), contentMode: .fit)
        )
    }
}

struct LoginButton : View {
    var body: some View {
        Text("Login")
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 250)
            .background(Color.purple, cornerRadius: 15)
            .border(Color.purple)
    }
}

#if DEBUG
struct Login_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
#endif
