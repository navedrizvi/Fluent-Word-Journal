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
        VStack {
            TopBar()
            Spacer()
            TextField($wordInput)
            .frame(width: 350, height: 500)
            .border(Color.purple, width: 2, cornerRadius: 15)
//            Spacer()
            Button(action: {
                // Closure will be called once user taps your button
                print(self.$wordInput)
            }) {
//                Spacer()
                SubmitButton()
                Spacer()
            }
            Spacer()
            MenuView()
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
        return PresentationLink(destination: AddWordsResults()) {
            HStack {
                Text("Submit")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding()
                
            }
                .frame(width: 350)
                .background(Color.purple, cornerRadius: 15)
                .border(Color.purple)


        }


    }
}


#if DEBUG
struct AddWords_Previews : PreviewProvider {
    static var previews: some View {
        AddWords()
    }
}
#endif

