//
//  DataService.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/14/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//
import Combine
import SwiftUI

struct WordnikConfig {
    static let apiKey = "338594680ac207c490101039b7506831a1d44fecb79bec7ec"
}

class NetworkManager: BindableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    var manyDefinitions = [Response]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let manyDefinitions = try JSONDecoder().decode([Response].self, from: data)
                DispatchQueue.main.async {
                    self.manyDefinitions = manyDefinitions
                }
            } catch let jsonErr {
                print("error serializing json: ", jsonErr)
            }
        }.resume()
    }
}

func getResponse(word: String)->[Response] {
    let url = "https://api.wordnik.com/v4/\(word).json/word/definitions?api_key=\(WordnikConfig.apiKey)"
    var nm = NetworkManager(url: url)
    return nm.manyDefinitions
}

func filterResponse(responses: [Response]) -> [Response] {
    let topResponses = Array(responses.prefix(8)) //get only first 8 responses
    return topResponses
}

func makeWord(word: String) {
    let responses = getResponse(word: word)
    let topResponses = filterResponse(responses: responses)
    
}
