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
//        {
//            print("Word: \(wordsFetched.title)")
//        } else {
//            print("Document does not exist")
//        }
        print(wordsFetched.words[0].title)
//        words = r
        
        
//        let rawData = document?.data()?["words"] as? [String:[String]]
////        let wordsFetched = document?.data()?["words"].flatMap { WordSnapshot(snapshot: $0 as! DocumentSnapshot)}
//
//        let wordsFetched = rawData.flatMap { WordSnapshot(snapshot: $0)}
//
//        print(wordsFetched)
    }
//        do {
////            let wordDocs = try JSONDecoder().decode([Response].self, from: doc)
////            DispatchQueue.main.async {
////                self.wordDocs = wordDocs
////            }
//
//            if let file = URL(string: urlStr) {
//                let data = try Data(contentsOf: file)
//                let model = try JSONDecoder().decode([Word].self, from:
//                    data)
//                words = model
//            }
//
//
//        } catch let jsonErr{
//            print("error: ", jsonErr)
//        }
//    }
//
//        let decoder = JSONDecoder()
//        var dict = doc.data()
//        for key, value in dict! {
//
//            }
//        if let data = try?  JSONSerialization.data(withJSONObject: dict!, options: []) {
//            let model = try? decoder.decode([Word].self, from: data)
//                words = model!
//
////          completion(words)
//    }
//    }
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

