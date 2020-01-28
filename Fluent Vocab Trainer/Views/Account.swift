//
//  Progress.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/18/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI
import Firebase

struct UserAccount : View {
    
    @EnvironmentObject var session: SessionStore
    @State var x = false;
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: AuthenticationView()) {
                SignOutButton(label: "Sign out", action: session.signOut)
            }
            
        }
    }
}

struct SignOutButton : View {
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
