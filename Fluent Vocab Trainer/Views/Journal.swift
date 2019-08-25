//
//  Journal.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/15/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct Journal : View {
    @EnvironmentObject var wordService: WordService

    var body: some View {
        NavigationView {
            List (wordService.words) { word in
                Text(word.title)
            }
        }.onAppear {
            self.getFromFireStore()
        }
    .navigationBarTitle("My Words")
    }

    private func getFromFireStore() {
        let user = Auth.auth().currentUser
        var uid:String = ""
        if let user = user {
            uid = user.uid
        }
        
        ref = Database.database().reference()
        let docRef = db.collection("words").document(uid)

        docRef.getDocument { (document, error) in
            guard let wordsFetched = document.flatMap({
              $0.data()?["words"].flatMap({ (data) in
                return WordsSnapshot(dictArray: data as! [[String:[String]]])
              })
            }) else {return}
            self.wordService.words = wordsFetched.words
        }
    }
    
}

#if DEBUG
struct Journal_Previews : PreviewProvider {
    static var previews: some View {
        Journal()
            .environmentObject(WordService())
    }
}
#endif
