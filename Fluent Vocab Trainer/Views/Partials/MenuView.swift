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
        return TabView {
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
            Progress()
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


struct MenuItem : View {
    var title = ""
    var icon = ""
    var body: some View {
            VStack {
            Image(systemName: icon)
                .imageScale(.large)
            //  .frame(width: 32, height: 20)
            //  .foregroundColor(Color(red: 0.6627450980392157, green: 0.7333333333333333, blue: 0.8313725490196079))
                .foregroundColor(Color(red: 1, green: 1, blue: 1))
            Text(title).font(.system(size: 12))
                .fontWeight(.medium)                .foregroundColor(Color(red: 172, green: 187, blue: 210))
        }
    }
}

struct Menu : Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

#if DEBUG
struct MenuView_Previews : PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

#endif




//                Spacer()
////            }
//            .padding(15)
//            // .padding(.bottom, 15)
//        }
//        .edgesIgnoringSafeArea(.top)
//            .background(Color.purple)
//            .cornerRadius(5)
//
//            .shadow(color: Color.purple, radius: 30, x: 0, y: 30)
//            .shadow(color: Color(hue: 0.68, saturation: 0.0, brightness: 0.0, opacity: 0.15), radius: 50, x: 0, y: 0)
//    }

