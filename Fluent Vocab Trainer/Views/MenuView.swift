//
//  ContentView.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/6/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct MenuView : View {
    
    var body: some View {
        VStack {
            TopBar()
            NavigationView {
                TabView {
                    Journal()
                        .tabItem {
                            VStack {
                                Image(systemName: "book.fill")
                                Text("Journal")
                            }
                    }.tag(0)
                    AddWords()
                        .tabItem {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add")
                            }
                    }.tag(1)
                    UserProgress()
                        .tabItem {
                            VStack {
                                Image(systemName: "person.fill")
                                Text("Progress")
                            }
                    }.tag(2)
                }
                .accentColor(Color.purple)
            }
        }
        
    }
}

#if DEBUG
struct MenuView_Previews : PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

#endif