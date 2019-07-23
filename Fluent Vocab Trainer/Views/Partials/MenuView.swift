//
//  ContentView.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/6/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct MenuView : View {
    //        @State var selectedTab = Tab.movies
    //    func tabbarItem(text: String, image: String) -> some View {
    //        VStack {
    //            Image(image)
    //            Text(text)
    //        }
    //    }
    //
    //    enum Tab: Int {
    //        case movies, discover, myLists
    //    }
    var menu: [Menu] = menuData
    
    var body: some View {
        //        TabbedView {//(selection: $selectedTab) {
        //            Practice().tabItemLabel(tabbarItem(text: menuData[0].title, image: menuData[0].icon))//.tag(0)
        //            Goals().tabItemLabel(tabbarItem(text:  menuData[1].title, image: menuData[1].icon))//.tag(1)
        //            Account().tabItemLabel(tabbarItem(text:  menuData[2].title, image:  menuData[2].icon))//.tag(2)
        //            }
        //            .edgesIgnoringSafeArea(.top)
        
        ZStack {
            HStack {
                Spacer()
                
                PresentationLink(destination: Practice()) {
                    MenuItem(title: menuData[0].title, icon: menuData[0].icon)
                }
                
                Spacer()
                Spacer()
                
                PresentationLink(destination: Goals()) {
                    MenuItem(title: menuData[1].title, icon: menuData[1].icon)
                }
                
                Spacer()
                Spacer()
                
                PresentationLink(destination: Profile()) {
                    MenuItem(title: menuData[2].title, icon: menuData[2].icon)
                }
                
                Spacer()
            }
            .padding(15)
            // .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.top)
            .background(Color.purple)
            .cornerRadius(5)
            
            .shadow(color: Color.purple, radius: 30, x: 0, y: 30)
            .shadow(color: Color(hue: 0.68, saturation: 0.0, brightness: 0.0, opacity: 0.15), radius: 50, x: 0, y: 0)
    }
}

struct MenuItem : View {
    var title = ""
    var icon = ""
    var body: some View {
        return VStack {
            Image(systemName: icon)
                .imageScale(.large)
                //                .frame(width: 32, height: 20)
                //                .foregroundColor(Color(red: 0.6627450980392157, green: 0.7333333333333333, blue: 0.8313725490196079))
                .foregroundColor(Color(red: 1, green: 1, blue: 1))
            Text(title).font(.system(size: 12))
                .fontWeight(.medium)//.fontWeight(10.0)
                .color(Color(red: 172, green: 187, blue: 210))
        }
    }
}

struct Menu : Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

let menuData = [
    Menu(title: "Practice", icon: "pencil"),
    Menu(title: "Goals", icon: "o.circle"),
    Menu(title: "Profile", icon: "person.fill")
]

#if DEBUG
struct MenuView_Previews : PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

#endif
