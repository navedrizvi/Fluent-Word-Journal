//
//  AddWords.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/7/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//
import UIKit
import SwiftUI

struct AddWords : View {
    @State var name: String = "Tim"
    
    var body: some View {
        VStack {
            TopBar()
            
            Text("ADD WORDS")
            
            // Spacer()
            TextField(.constant(""), placeholder: Text("Enter one or many words...")) {
                
            }
            .multilineTextAlignment(.leading)
                .frame(height: 400)
                .textFieldStyle(.roundedBorder)
            NavigationView {
                
                SubmitButton()
                Spacer()
            }
        }
    }
    
    private func endEditing(_ force: Bool) {
        UIApplication.shared.keyWindow?.endEditing(force)
    }
}


#if DEBUG
struct AddWords_Previews : PreviewProvider {
    static var previews: some View {
        AddWords()
    }
}
#endif

struct SubmitButton : View {
    var body: some View {
        return PresentationLink(destination: AddWordsResults()) {
            Text("Submit")
                .fontWeight(.heavy)
                .foregroundColor(Color.purple)
                .padding()
        }
        .border(Color.purple, width: 2, cornerRadius: 15)
    }
}
