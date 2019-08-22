//
//  AddWords.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/7/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//
import UIKit
import SwiftUI
import Firebase

struct AddWords : View {
    
    @State var wordInput: String = ""
    
    var body: some View {
        NavigationView {
        VStack {
            TextField("Enter words to learn...", text: $wordInput)
                .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 200)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
//                print(self.$wordInput)
//                print(self.wordInput)
                let words = makeWords(userInput: self.wordInput)
                addToFireStore(words: words)
            }) {
                            NavigationLink(destination: AddWordsResults())    {
                SubmitButton()
                Spacer()
            }
            }
            
        }
    }
    }
    
}

struct SubmitButton : View {
    var body: some View {
        Text("Submit")
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 250)
            .background(Color.purple)
            .border(Color.purple)
            .cornerRadius(15)
    }
}


#if DEBUG
struct AddWords_Previews : PreviewProvider {
    static var previews: some View {
        AddWords()
    }
}
#endif

