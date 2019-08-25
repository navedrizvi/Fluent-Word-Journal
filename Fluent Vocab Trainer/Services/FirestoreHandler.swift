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
                docRef.updateData(["words":FieldValue.arrayUnion(words)]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document updated with ID: \(uid)")
                    }
                }
            } else {
                docRef.setData([ "words": words], merge: true) { err in
                    if let err = err {
                        print("Error setting document: \(err)")
                    } else {
                        print("Document set with ID: \(uid)")
                    }
                }
            }
        }
    })
}

func getFromFireStore() -> [Word]? {
    let user = Auth.auth().currentUser
    var uid:String = ""
    if let user = user {
        uid = user.uid
    }
    
    var words = [Word]()
    
    ref = Database.database().reference()
    let docRef = db.collection("words").document(uid)

    docRef.getDocument { (document, error) in
        guard let wordsFetched = document.flatMap({
          $0.data()?["words"].flatMap({ (data) in
            return WordsSnapshot(dictArray: data as! [[String:[String]]])
          })
        }) else {return}
        words = wordsFetched.words
        print(words[0].title)
    }
//    print(words[0].title)
    
    return words
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

class WordService: ObservableObject {
//    let objectWillChange = ObservableObjectPublisher()
//    var words: [Word] = [] {
//        willSet {
//            self.objectWillChange.send()
//        }
//    }
    @Published var words: [Word] = []
    func fetch() {
        guard let wordsFetched = getFromFireStore() else {return}
        print(wordsFetched)
        self.words = wordsFetched
    }
}

