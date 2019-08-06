//
//  DataService.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/14/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//
import Combine
import SwiftUI
import SwiftyJSON
import Firebase

//firebase setup
let db = Firestore.firestore()
var ref: DatabaseReference!
fileprivate var _refHandle: DatabaseHandle!

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

func getResponse(word: String)->[Response]? {
    let word = word.lowercased()
    let urlStr = "https://api.wordnik.com/v4/word.json/\(word)/definitions?api_key=\(WordnikConfig.apiKey)"
    var responses = [Response]()
    do {
        if let file = URL(string: urlStr) {
            let data = try Data(contentsOf: file)
            let model = try JSONDecoder().decode([Response].self, from:
                data)
            responses = model
        }
    } catch let jsonErr {
        print("Error", jsonErr)
    }
    
    return responses
}

func wordMaker(word input:String)-> Word?{
    guard let response = getResponse(word: input) else {
        print("could not find word")
        return nil
    }
    
    //Process response arrat to single word
    let wordAdded = input.capitalizingFirstLetter() //from string extension
    let wordUrl = response[0].wordnikUrl!
    
    let responseSlice = response.prefix(10) //consider top 10 responses
    
    //Add defifinitions
    var wordDefinitions = [String]()
    var counter1 = 0
    for response in responseSlice {
        if counter1 == 5 { //not include more than 5
            continue
        }
        guard let definition = response.text else { continue }
        wordDefinitions.append(definition)
        counter1 += 1
    }
    
    //Add parts of speech word is used in
    var partsOfSpeech = Set<String>() //Keep unique parts of speech
    var counter2 = 0
    for response in responseSlice {
        if counter2 == 5 {
            continue
        }
        guard let pos = response.partOfSpeech else { continue }
        partsOfSpeech.insert(pos)
        counter2 += 1
    }

    //Add example uses
    var exampleUses = [String]()
    var counter3 = 0
    for response in responseSlice {
        if counter3 == 5 {
            continue
        }
        if let exampleArr = response.exampleUses {
            counter3 += 1
            for (_, text) in exampleArr { //needs extra parsing
                exampleUses.append(text["text"].stringValue)
            }
        }
    }
    
    let word = Word(word: wordAdded, url: wordUrl, fiveDefinitions: wordDefinitions, partsOfSpeech: Array(partsOfSpeech), exampleUses: exampleUses)
    
    return word
}

func makeWords(userInput: String) -> [Word] {
    var wordsArr = [Word]()
    //user input processing
    let inputArr = rawToArray(str: userInput)
    let filteredArr = inputArr.map { removeCharacters(word: $0) }//To filter out letters (removing commas), mapped to each element in array
    for input in filteredArr {
        let word = wordMaker(word: input)
        guard let wordSearched = word else { continue }
        wordsArr.append(wordSearched) //if word is found
    }
    return wordsArr
}

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

//helpers
func rawToArray(str: String) -> [String] {
    var arr = str.components(separatedBy: "\n") //seperate by newline
    arr = arr.filter {$0 != ""} //remove empty strings
    return arr
}

func removeCharacters(word: String) -> String {
    return String(word.unicodeScalars.filter({ CharacterSet.letters.contains($0) }))
}



struct APIView: View {
    var body: some View {
        Text("Hello World")
    }
}

#if DEBUG
struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView()
    }
}
#endif
