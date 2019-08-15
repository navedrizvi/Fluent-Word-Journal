//import SwiftUI
//import Combine
//import Foundation
////import SwiftyJSON
//
//extension String {
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
//    
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//}
//
//class Word {
//    var title: String
//    var wordnikUrl: String
//    var definitions: [String] //5 fields
//    var partsOfSpeech: [String]
//    var examples: [String]
//    var dateAdded: String
//
//    init(word word: String, url url: String, fiveDefinitions fiveDefinitions: [String], partsOfSpeech pos: [String], exampleUses exampleUses: [String]) {
//        title = word
//        wordnikUrl = url
//        definitions = fiveDefinitions
//        partsOfSpeech = pos
//        examples = exampleUses
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        dateAdded = formatter.string(from: date)
//    }
//}
//
//struct WordnikConfig {
//    static let apiKey = "338594680ac207c490101039b7506831a1d44fecb79bec7ec"
//}
//
//class NetworkManager: BindableObject {
//    var didChange = PassthroughSubject<NetworkManager, Never>()
//    
//    var manyDefinitions = [Response]() {
//        didSet {
//            didChange.send(self)
//        }
//    }
//    
//    init(url: String) {
//        guard let url = URL(string: url) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            
//            guard let data = data else { return }
//            
//            do {
//                let manyDefinitions = try JSONDecoder().decode([Response].self, from: data)
//                DispatchQueue.main.async {
//                    self.manyDefinitions = manyDefinitions
//                }
//            } catch let jsonErr {
//                print("error serializing json: ", jsonErr)
//            }
//        }.resume()
//    }
//}
//
////JSON parsing model
//struct Response: Decodable {
//    var word: String?
//    var wordnikUrl: String?
//    var text: String?
//    var partOfSpeech: String?
//    var exampleUses: JSON?
//    
//    init(json: [String: Any]) {
//        word = json["word"] as? String ?? nil
//        wordnikUrl = json["wordnikUrl"] as? String ?? nil
//        
//        if (json["text"] == nil){
//            text = nil
//        } else {
//            text = json["text"] as? String ?? nil
//        }
//        
//        if (json["partOfSpeech"] == nil){
//            partOfSpeech = nil
//        } else {
//            partOfSpeech = json["partOfSpeech"] as? String ?? nil
//        }
//        
//        if (json["exampleUses"] == nil){
//            exampleUses = nil
//        }
//        else {
//            exampleUses = json["exampleUses"] as? JSON ?? nil
//        }
//    }
//}
//
//
//
//
//
//
//
//
//
//
//func getResponse(word: String)->[Response]? {
//    let word = word.lowercased()
//    let urlStr = "https://api.wordnik.com/v4/word.json/\(word)/definitions?api_key=\(WordnikConfig.apiKey)"
//    var responses = [Response]()
//    do {
//        if let file = URL(string: urlStr) {
//            let data = try Data(contentsOf: file)
//            let model = try JSONDecoder().decode([Response].self, from:
//                data)
//            responses = model
//        }
//    } catch let jsonErr {
//        print("Error", jsonErr)
//    }
//
//    return responses
//}
//
//func wordMaker(word input:String)-> Word?{
//    guard let response = getResponse(word: input) else {
//        print("could not find word")
//        return nil
//    }
//    
//    //Process response arrat to single word
//    let wordAdded = input.capitalizingFirstLetter() //from string extension
//    let wordUrl = response[0].wordnikUrl!
//    
//    let responseSlice = response.prefix(10) //consider top 10 responses
//
//    //Add defifinitions
//    var wordDefinitions = [String]()
//    var counter1 = 0
//    for response in responseSlice {
//        if counter1 == 5 { //not include more than 5
//            continue
//        }
//        guard let definition = response.text else { continue }
//        wordDefinitions.append(definition)
//        counter1 += 1
//    }
//    
//    //Add parts of speech word is used in
//    var partsOfSpeech = Set<String>() //Keep unique parts of speech
//    var counter2 = 0
//    for response in responseSlice {
//        if counter2 == 5 {
//            continue
//        }
//        guard let pos = response.partOfSpeech else { continue }
//        partsOfSpeech.insert(pos)
//        counter2 += 1
//    }
//    
//    //Add example uses
//    var exampleUses = [String]()
//    var counter3 = 0
//    for response in responseSlice {
//        if counter3 == 5 {
//            continue
//        }
//        if let exampleArr = response.exampleUses {
//            counter3 += 1
//            for (temp, text) in exampleArr { //needs extra parsing
//                if text["text"] != nil {
//                    exampleUses.append(text["text"].stringValue)
//                }
//            }
//        }
//    }
//    
//    let word = Word(word: wordAdded, url: wordUrl, fiveDefinitions: wordDefinitions, partsOfSpeech: Array(partsOfSpeech), exampleUses: exampleUses)
//    
//    return word
//}
////
////func addToFirebase(word word:Word) {
////
////}
////
////func firebaseHandler() {
////
////    addToFirebase(word)
////}
////
////func multipleWordsHandler() {
////    let input = "word"
////    let word = responseHandler(word: input)
////}
////
////
//
////helpers
//func rawToArray(str: String) -> [String] {
//    var arr = str.components(separatedBy: "\n") //seperate by newline
//    arr = arr.filter {$0 != ""} //remove empty strings
//    return arr
//}
//
//func removeCharacters(word: String) -> String {
//    return String(word.unicodeScalars.filter({ CharacterSet.letters.contains($0) }))
//}
//
////if (textBox.text != "") {
////    addWords(words: wordsArr)
////}
////else {
////    let alertController = UIAlertController(title: "No text", message:
////        "Please enter some words in order to add them to your journal", preferredStyle: .alert)
////    alertController.addAction(UIAlertAction(title: "OK", style: .default))
////
////    self.present(alertController, animated: true, completion: nil)
////}
//
//
//
////to allow searching multiple words at once
//func makeWords(userInput: String) -> [Word] {
//    var wordsArr = [Word]()
//    //user input processing
//    let inputArr = rawToArray(str: userInput)
//    var filteredArr = inputArr.map { removeCharacters(word: $0) }//To filter out letters (removing commas), mapped to each element in array
//    for input in filteredArr {
//        let word = wordMaker(word: input)
//        guard let wordSearched = word else { continue }
//        wordsArr.append(wordSearched) //if word is found
//    }
//    return wordsArr
//}

//func main() {
//    let userInput = "new,\nold\nphilosophy,"
//    let words = makeWords(userInput: userInput)
//
//}
//let word = wordMaker(word: "old") //been handled by swiftify
//print(word?.examples)


import SwiftUI

struct Login : View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
        }
    }
}

#if DEBUG
struct Login_Previews : PreviewProvider {
    static var previews: some View {
        Login()
    }
}
#endif
