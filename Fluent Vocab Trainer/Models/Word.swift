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

class Word {
    var title: String
    var wordnikUrl: String
    var definitions: [String] //with 5 values
    var partsOfSpeech: [String]
    var examples: [String]
    var dateAdded: String
    
    init(word: String, url: String, fiveDefinitions defs: [String], partsOfSpeech pos: [String], exampleUses: [String]) {
        title = word
        wordnikUrl = url
        definitions = defs
        partsOfSpeech = pos
        examples = exampleUses
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateAdded = formatter.string(from: date)
    }
}
