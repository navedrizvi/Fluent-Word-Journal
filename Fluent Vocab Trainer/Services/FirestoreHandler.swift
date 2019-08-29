//
//  StorageHandler.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/15/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import Foundation
import Firebase
import Combine

//firebase setup
let db = Firestore.firestore()
var ref: DatabaseReference!
fileprivate var _refHandle: DatabaseHandle!

// Adds only unique words to user's account (document) on Firestore
func addToFireStore(words: [Word]) {
    ref = Database.database().reference()
    let user = Auth.auth().currentUser
    
    var uid = ""
    if let user = user {
        uid = user.uid
    }
    
    let docRef = db.collection("words").document(uid)
    
    //Convert words to string dictionary and stores in firebase
    let words = words.map {$0.toDict()}
    
    docRef.getDocument(completion: { (document, error) in
        if let document = document {
            if document.exists{
                for word in words {
                    docRef.updateData([word["title"]![0]: word]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document updated with ID: \(uid)")
                        }
                    }
                }
            }
            else {
                for word in words {
                    docRef.setData([word["title"]![0]: word]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document updated with ID: \(uid)")
                        }
                    }
                }
            }
        }
    })
}



class WordService: ObservableObject {
    @Published var words: [Word] = []
    
    public func fetch(completion: @escaping () -> ()) {
        self.getFromFireStore(completion: completion)
    }
    
    private func getFromFireStore(completion: @escaping () -> ()) {
        let user = Auth.auth().currentUser
        var uid:String = ""
        if let user = user {
            uid = user.uid
        }
        
        var wordsStored = [Word]()
        
        ref = Database.database().reference()
        let docRef = db.collection("words").document(uid)
        
        docRef.getDocument { (document, error) in
            guard let wordsFetched = document.flatMap({
                $0.data().flatMap { (doc) in
                    doc.compactMap({ (dict) in
                        return WordSnapshot(key: dict.key, value: dict.value as! [String:[String]])
                    })
                }
            }) else {return}
            for each in wordsFetched {
                wordsStored.append(each.word)
            }
            self.words = wordsStored
            completion()
        }
    }
}

//helper
func dataToWord(rawData: [String: [String]]) -> Word {
    let title = rawData["title"]?[0]
    let wordnikUrl = rawData["wordnikUrl"]?[0]
    let definitions = rawData["definitions"]
    let partsOfSpeech = rawData["partsOfSpeech"]
    let examples = rawData["examples"]
    let dateAdded = rawData["dateAdded"]?[0]
    
    let word = Word(title: title!, url: wordnikUrl!, fiveDefinitions: definitions!, partsOfSpeech: partsOfSpeech!, examples: examples!, date: dateAdded!)
    
    return word
}
