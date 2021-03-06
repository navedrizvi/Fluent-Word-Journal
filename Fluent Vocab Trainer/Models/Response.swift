//
//  Response.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/5/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//
import Foundation
import SwiftUI
import SwiftyJSON

//JSON parsing model
struct Response: Decodable {
    var word: String?
    var wordnikUrl: String?
    var text: String?
    var partOfSpeech: String?
    var exampleUses: JSON? //server is ambiguous here
    
    init(json: [String: Any]) {
        word = json["word"] as? String ?? nil
        wordnikUrl = json["wordnikUrl"] as? String ?? nil
        
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
            exampleUses = json["exampleUses"] as? JSON ?? nil
        }
    }
}
