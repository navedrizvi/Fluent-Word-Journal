//
//  WordDetail.swift
//  Fluent Vocab Trainer
//
//  Created by Naved Rizvi on 8/25/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct WordDetail: View {
    var word: Word
    
    var body: some View {
        Group {
            Text(word.title)
                .font(.title)
                .padding(.bottom)
            
            VStack (alignment: .leading) {
                Text("Definitions: ").foregroundColor(Color.purple).padding(0.5)
                ForEach(word.definitions, id: \.self) { definition in
                    Text("\u{2022} \(definition)")
                        .lineLimit(2)
//                        .lineLimit(nil)
//                        .font(.body)
                }
                if (!word.examples.isEmpty){
                    Spacer()
                    Text("Examples: ").foregroundColor(Color.purple).padding(0.5)
                    ForEach(word.examples, id: \.self) { (example) in
                        Text("\u{2022} \(example)")
                        .lineLimit(2)
                    }
                }
                if (!word.partsOfSpeech.isEmpty){
                    Spacer()
                    Text("Part of speech as: ").foregroundColor(Color.purple).padding(0.5)
                    //                .font(.bold)
                    ForEach(word.partsOfSpeech, id: \.self) { partOfSpeech in
                        Text(verbatim: partOfSpeech)
                    }
                }
            }
            .frame(width: 350)
            Spacer()
            Button(action: {
                if let url = URL(string: self.word.wordnikUrl) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(word.wordnikUrl)
                    .underline()
                    .padding(.bottom)
                    .foregroundColor(Color.blue)
            }

        }
        
    }
}
