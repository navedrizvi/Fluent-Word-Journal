//
//  StorageHandler.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/15/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import Foundation
import Firebase

//firebase setup
let db = Firestore.firestore()
var ref: DatabaseReference!
fileprivate var _refHandle: DatabaseHandle!


// Adds only unique words to user's account (document) on Firestore
func addToFireStore(words: [Word]) {
    let user = Auth.auth().currentUser
    var uid:String=""
    if let user = user {
        uid = user.uid
    }
    let docRef = db.collection("userData").document(uid)
    docRef.getDocument(completion: { (document, error) in
        if let document = document {
            if document.exists{
                db.collection("userData").document(uid).setData([ "words": words], merge: true) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document updated with ID: \(uid)")
                    }
                }
            } else {
                db.collection("userData").document(uid).setData([
                    "userID": uid,
                    "words": words,
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(uid)")
                    }
                }
            }
        }
    })
}

func main() {
    let userInput = "new,\nold\nphilosophy,"
    let words = makeWords(userInput: userInput)
    addToFireStore(words: words)
}
