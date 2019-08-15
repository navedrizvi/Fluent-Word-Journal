//
//  SwiftUIView.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/14/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct AddWordsResults : View {
    
//    @State var networkManager = NetworkManager()
    
    var body: some View {
//        NavigationView {
//            List (
////                networkManager.manyDefinitions.identified(by: \.title)
//
//            )
////            { manyDefinitions in
////                WordRowView(word: manyDefinitions)
////            }
//            .navigationBarTitle(Text("Words"))
//        }
        VStack{
            WordRowView(word:"new")
            Text("hii")
        }

    }
}

struct WordRowView: View {
//    let word: Word
    let word: String

    var body: some View {
//        VStack (alignment: .leading) {
////            if word.title != nil {
////                Text(word.title!)
////            }
////            if word.wordnikUrl != nil {
////                Text(word.wordnikUrl!)
////            }
//
//
////            Text(word.exampleUses)
//        }
        Text("hii")
    }
}


#if DEBUG
struct SwiftUIView_Previews : PreviewProvider {
    static var previews: some View {
        //        SwiftUIView()
        AddWordsResults()
    }
}
#endif
