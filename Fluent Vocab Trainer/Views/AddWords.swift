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
    @State var wordInput: String = ""
    var body: some View {
        NavigationView {
                    VStack {
                        TopBar()
                        Spacer()
                        TextField("Enter words to learn...", text: $wordInput)
            //            .frame(width: CGFloat(350), height: CGFloat(500))
            //            .border(Color.purple, width: CGFloat(2), cornerRadius: CGFLoat(15))
            //            Spacer()
                        Button(action: {
                            print(self.$wordInput)
                        }) {
                            SubmitButton()
                            Spacer()
                        }
                        Spacer()
                        MenuView()
                    }
        }

        
//        VStack {
//            TopBar()
//
//            Text("ADD WORDS")
//
//            // Spacer()
//            TextField(.constant(""), placeholder: Text("Enter one or many words...")) {
//
//            }
//            .multilineTextAlignment(.leading)
//                .frame(height: 400)
//                .textFieldStyle(.roundedBorder)
//            NavigationView {
//
//                SubmitButton()
//                Spacer()
//            }
//        }
    }
    
    private func endEditing(_ force: Bool) {
        UIApplication.shared.keyWindow?.endEditing(force)
    }
}

struct SubmitButton : View {
    var body: some View {
        Text("Submit")
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 350)
            .background(Color.purple, cornerRadius: 15)
            .border(Color.purple)
    }
}


#if DEBUG
struct AddWords_Previews : PreviewProvider {
    static var previews: some View {
        AddWords()
    }
}
#endif

