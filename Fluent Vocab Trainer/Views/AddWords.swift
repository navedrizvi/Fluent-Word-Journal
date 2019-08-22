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
    
    @State private var wordInput: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter words...", text: $wordInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SubmitButton(wordInput: $wordInput) //passing the input state on submit
            }
        }.navigationBarTitle("Results")
    }
    
}

struct SubmitButton : View {
    @Binding var wordInput: String
    @State var showingAlert = false
    @State var successWords = [String]()
    @State var failedWords = [String]()
    var body: some View {
        Button(action: {
            let (words, successes, failures) = makeWords(userInput: self.wordInput)
            self.successWords = successes
            self.failedWords = failures
            addToFireStore(words: words)
            self.showingAlert = true
            self.wordInput = ""
        }) {
            Text("Submit")
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .padding()
                .frame(width: 250)
                .background(Color.purple)
                .border(Color.purple)
                .cornerRadius(15)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Results"), message: AlertMessage(wordsFound: successWords, wordsNotFound: failedWords), dismissButton: .default(Text("Dismiss")))
        }
    }
}

fileprivate func AlertMessage(wordsFound success:[String], wordsNotFound fail:[String]) -> Text {
    var messageString = "\nSucessfully added:\n\n"
    for word in success {
        messageString += "\(word)\n"
    }
    if !fail.isEmpty{
        messageString += "\nCould not find:\n\n"
        for word in fail {
            messageString += "\(word)\n"
        }
    }
    
    return Text(messageString).fontWeight(.regular)
    
}

#if DEBUG
struct AddWords_Previews : PreviewProvider {
    static var previews: some View {
        AddWords()
    }
}
#endif

