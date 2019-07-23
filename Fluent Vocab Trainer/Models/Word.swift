//
//  File.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 7/21/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import Foundation
import SwiftUI

struct Word: Hashable, Codable{
    var word: String

    var wordnikUrl: String

}

struct Response: Hashable, Decodable {
    var word: String
    var wordnikUrl: String
    var text: String?
    var partOfSpeech: String?
    var exampleUses: [Dictionary<String, String>]?
    
    init(json: [String: Any]) {
        word = json["word"] as? String ?? ""
        wordnikUrl = json["wordnikUrl"] as? String ?? ""
        
        if (json["text"] == nil){
            text = nil
        } else {
            text = json["text"] as? String ?? nil
        }
        
        if (json["partOfSpeech"] == nil){
            partOfSpeech = nil
        } else {
            partOfSpeech = json["partOfSpeech"] as? String ?? nil
        }
        
        if (json["exampleUses"] == nil){
            exampleUses = nil
        }
        else {
            exampleUses = json["exampleUses"] as? [Dictionary<String, String>] ?? nil
        }
    }
}
