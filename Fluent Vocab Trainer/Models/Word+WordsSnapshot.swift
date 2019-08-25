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

struct WordsSnapshot {
    var words = [Word]()
    
    init?(dictArray: [[String:[String]]]) {
        //mapping each word
        for word in dictArray {
            words.append(Word(title: word["title"]![0], url: word["wordnikUrl"]![0], fiveDefinitions: word["definitions"]!, partsOfSpeech: word["partsOfSpeech"]!, examples: word["examples"]!, date: word["dateAdded"]![0]))
        }
    }
}