//
//  TopBar.swift
//  Vocabulary Trainer
//
//  Created by Naved Rizvi on 7/7/19.
//  Copyright © 2019 Naved Rizvi. All rights reserved.
//

import SwiftUI

struct TopBar : View {
    var body: some View {
        // var title = ""
        //ZStack(alignment: .topLeading) {
        //   Text(title).padding().padding(.top, 30).font(.largeTitle).foregroundColor(.white)//.transition(.move(edge: .leading))
        
        return Rectangle()//.relativeHeight(0.2)
            .foregroundColor(Color.purple)
            .edgesIgnoringSafeArea(.top)
            .frame(maxHeight: 20)
            .shadow(color: Color.purple, radius: 30, x: 0, y: 20)
            .shadow(color: Color(hue: 0.68, saturation: 0.0, brightness: 0.0, opacity: 0.15), radius: 50, x: 0, y: 0)
    }
    //    /}
}
