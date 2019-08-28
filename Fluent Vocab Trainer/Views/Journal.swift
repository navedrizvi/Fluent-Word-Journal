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
    @State private var searchQuery: String = ""
    @State private var isLoading = true
    var body: some View {
        LoadingView(isShowing: .constant(isLoading)) {
            NavigationView {
                List {
                    Section(header: SearchBar(text: self.$searchQuery)) {
                        ForEach ((self.wordService.words).filter {
                            self.searchQuery.isEmpty ?
                                true :
                                "\($0.title)".contains(self.searchQuery)
                        }) { word in
                            NavigationLink(destination: WordDetail(word: word)) {
                                Text(word.title)
                            }
                        }
                        .onDelete(perform: self.delete)
                        .onMove(perform: self.move)
                    }
                }
                .navigationBarItems(trailing: EditButton())
                .navigationBarTitle("My Words")
            }.onAppear {
                self.getFromFireStore()
            }
        }
        
    }
    
    private func delete(at offsets: IndexSet) {
        deleteFromFirestore(at: offsets)
        wordService.words.remove(atOffsets:offsets)
    }
    
    private func deleteFromFirestore(at offsets: IndexSet) {
        let user = Auth.auth().currentUser
        var uid:String = ""
        if let user = user {
            uid = user.uid
        }
        
        ref = Database.database().reference()
        let docRef = db.collection("words").document(uid)
        
        let input = offsets.map { self.wordService.words[$0] }
        //Convert words to string dictionary to remove from firebase
        let word = input[0].toDict()
        docRef.updateData(["words": FieldValue.arrayUnion([word])]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document updated with ID: \(uid)")
            }
        }

        
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        wordService.words.move(fromOffsets: source, toOffset: destination)
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
            self.isLoading = false
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
