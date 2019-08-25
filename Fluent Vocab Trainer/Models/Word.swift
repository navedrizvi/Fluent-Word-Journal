//
//  File.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 7/21/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Firebase

class Word: Codable, Identifiable {
    var id = UUID()
    var title: String
    var wordnikUrl: String
    var definitions: [String] //with 5 values
    var partsOfSpeech: [String]
    var examples: [String]
    var dateAdded: String
    
    init(title word: String, url: String, fiveDefinitions defs: [String], partsOfSpeech pos: [String], examples exampleUses: [String], date dateAdded: String) {
        title = word
        wordnikUrl = url
        definitions = defs
        partsOfSpeech = pos
        examples = exampleUses
        self.dateAdded = dateAdded
    }
    
    public func toJson() -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        
        return jsonData
    }
    
    public func toString() -> String {
        let jsonData = self.toJson()
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        
        return jsonString
    }
    
    public func toDict() -> [String:[String]] {
        var dict: [String: [String]] = [:]
        dict["title"] = [self.title]
        dict["wordnikUrl"] = [self.wordnikUrl]
        dict["definitions"] = self.definitions
        dict["partsOfSpeech"] = self.partsOfSpeech
        dict["examples"] = self.examples
        dict["dateAdded"] = [self.dateAdded]
        
        return dict
    }
    
}

//struct WordSnapshot {
//    let title: String
//    let wordnikUrl: String
//    var definitions: [String]
//    var partsOfSpeech: [String]
//    var examples: [String]
//    var dateAdded: String
//
//    init?(snapshot: DocumentSnapshot) {
////        guard let data = snapshot as? [String:[String]],
////        let title = data["title"]?[0],
////        let wordnikUrl = data["wordnikUrl"]?[0],
////        let definitions = data["definitions"],
////        let partsOfSpeech = data["partsOfSpeech"],
////        let examples = data["examples"],
////        let dateAdded = data["dateAdded"]?[0]
////        else {return nil}
////        guard let data = snapshot as? [[String:[String]]],
//        guard let data = snapshot.data() as? [String:[String]],
//            let title = data["title"]?[0],
//            let wordnikUrl = data["wordnikUrl"]?[0],
//            let definitions = data["definitions"],
//            let partsOfSpeech = data["partsOfSpeech"],
//            let examples = data["examples"],
//            let dateAdded = data["dateAdded"]?[0]
//            else {return nil}
////        let rawData = data["words"] as? [[String:[String]]]
////        guard let dic = snapshot.value as? [String:Any],
////              let title = dic["title"] as? String,
////              let desc = dic["description"] as? String else {
////            return nil
////        }
//        self.title = title
//        self.wordnikUrl = wordnikUrl
//        self.definitions = definitions
//        self.partsOfSpeech = partsOfSpeech
//        self.examples = examples
//        self.dateAdded = dateAdded
//    }
//}

struct WordsSnapshot {
    var title = [String]()
    var wordnikUrl = [String]()
    var definitions = [[String]]()
    var partsOfSpeech = [[String]]()
    var examples = [[String]]()
    var dateAdded = [String]()
    
    init?(dictArray: [[String:[String]]]) {
        //mapping each word
        for word in dictArray {
            title.append(word["title"]![0])
            wordnikUrl.append(word["wordnikUrl"]![0])
            definitions.append(word["definitions"]!)
            partsOfSpeech.append(word["partsOfSpeech"]!)
            examples.append(word["examples"]!)
            dateAdded.append(word["dateAdded"]![0])
            
        }
        
//        guard let title = dictionary["title"]?[0],
//            let wordnikUrl = dictionary["wordnikUrl"]?[0],
//            let definitions = dictionary["definitions"],
//            let partsOfSpeech = dictionary["partsOfSpeech"],
//            let examples = dictionary["examples"],
//            let dateAdded = dictionary["dateAdded"]?[0]
//            else {return nil}

//        self.title = title
//        self.wordnikUrl = wordnikUrl
//        self.definitions = definitions
//        self.partsOfSpeech = partsOfSpeech
//        self.examples = examples
//        self.dateAdded = dateAdded
    }
}
