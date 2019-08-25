//
//  Journal.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/15/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI
import Combine

struct Journal : View {
    @EnvironmentObject var wordStore: WordService
//    @ObservedObject var wordStore: WordStore
//
//    @State public var words: [Word]
    
    var body: some View {
        NavigationView {
            List (wordStore.words) { word in
                Text(word.title)
            }
        }.onAppear {
            self.fetch()
        }//(perform: fetch)
    }
    
    private func fetch() {
//        guard let wordStore = getFromFireStore() else {return}
//        print(wordStore)
//        self.wordStore = wordStore
        guard let words = getFromFireStore() else {return}
        print(words)
        wordStore.fetch()
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
